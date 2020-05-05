Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF92C47259
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 05:19:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8840206FA
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 05:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2uBeHQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8840206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B6C8A86C9B;
	Tue,  5 May 2020 05:19:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6DLxfs4qXcG; Tue,  5 May 2020 05:19:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EE63F86C2E;
	Tue,  5 May 2020 05:19:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD3A1C088A;
	Tue,  5 May 2020 05:19:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C19A7C0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 05:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B583A22882
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 05:19:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xYyVBbGgN6xU for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 05:19:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 74BCB2287D
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 05:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588655988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDox4kEBOjt8ok5EwDS4BtmzAHx0WC6c0UbWruHoZeA=;
 b=N2uBeHQMbW3b0aiwpfFobLIp1GAhh1yeur7UO5RMLkekOagkizLlaBt/HWCFcGWhcs240u
 15GtiNmjKaG5atAQRHYSbMgxJKezfk7EnSW7Xea8uXrSDM5BdFAbBg19J7xhsswgvGBUOt
 X9ggcU6mc2RTBM9n8HrWo35Qv5g9K3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-iSxElwQHOpamPjQotqIKYw-1; Tue, 05 May 2020 01:19:40 -0400
X-MC-Unique: iSxElwQHOpamPjQotqIKYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EE1A1005510;
 Tue,  5 May 2020 05:19:38 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86DD25D9D3;
 Tue,  5 May 2020 05:19:37 +0000 (UTC)
Date: Mon, 4 May 2020 23:19:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200504231936.2bc07fe3@x1.home>
In-Reply-To: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Darrel Goeddel <DGoeddel@forcepoint.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Mark Scott <mscott@forcepoint.com>, Romil Sharma <rsharma@forcepoint.com>,
 Bjorn Helgaas <bhelgaas@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon,  4 May 2020 21:42:16 -0700
Ashok Raj <ashok.raj@intel.com> wrote:

> PCIe Spec recommends we can relax ACS requirement for RCIEP devices.
> 
> PCIe 5.0 Specification.
> 6.12 Access Control Services (ACS)
> Implementation of ACS in RCiEPs is permitted but not required. It is
> explicitly permitted that, within a single Root Complex, some RCiEPs
> implement ACS and some do not. It is strongly recommended that Root Complex
> implementations ensure that all accesses originating from RCiEPs
> (PFs and VFs) without ACS capability are first subjected to processing by
> the Translation Agent (TA) in the Root Complex before further decoding and
> processing. The details of such Root Complex handling are outside the scope
> of this specification.
> 
> Since Linux didn't give special treatment to allow this exception, certain
> RCiEP MFD devices are getting grouped in a single iommu group. This
> doesn't permit a single device to be assigned to a guest for instance.
> 
> In one vendor system: Device 14.x were grouped in a single IOMMU group.
> 
> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> /sys/kernel/iommu_groups/5/devices/0000:00:14.3
> 
> After the patch:
> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> /sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group
> 
> 14.0 and 14.2 are integrated devices, but legacy end points.
> Whereas 14.3 was a PCIe compliant RCiEP.
> 
> 00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
> Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
> 
> This permits assigning this device to a guest VM.
> 
> Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> To: Joerg Roedel <joro@8bytes.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
> Cc: Mark Scott <mscott@forcepoint.com>,
> Cc: Romil Sharma <rsharma@forcepoint.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/iommu.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2b471419e26c..5744bd65f3e2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1187,7 +1187,20 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
>  	struct pci_dev *tmp = NULL;
>  	struct iommu_group *group;
>  
> -	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> +	/*
> +	 * PCI Spec 5.0, Section 6.12 Access Control Service
> +	 * Implementation of ACS in RCiEPs is permitted but not required.
> +	 * It is explicitly permitted that, within a single Root
> +	 * Complex, some RCiEPs implement ACS and some do not. It is
> +	 * strongly recommended that Root Complex implementations ensure
> +	 * that all accesses originating from RCiEPs (PFs and VFs) without
> +	 * ACS capability are first subjected to processing by the Translation
> +	 * Agent (TA) in the Root Complex before further decoding and
> +	 * processing.
> +	 */

Is the language here really strong enough to make this change?  ACS is
an optional feature, so being permitted but not required is rather
meaningless.  The spec is also specifically avoiding the words "must"
or "shall" and even when emphasized with "strongly", we still only have
a recommendation that may or may not be honored.  This seems like a
weak basis for assuming that RCiEPs universally honor this
recommendation.  Thanks,

Alex

> +	if (!pdev->multifunction ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) ||
> +	     pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>  		return NULL;
>  
>  	for_each_pci_dev(tmp) {

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
