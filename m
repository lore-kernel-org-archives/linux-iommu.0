Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8605EC433E5
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 12:35:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501E4207FC
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 12:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cvv34eAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501E4207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 156A887E6F;
	Mon, 20 Jul 2020 12:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OJhKRzLSSlRV; Mon, 20 Jul 2020 12:35:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6DDDE87E6E;
	Mon, 20 Jul 2020 12:35:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52624C0894;
	Mon, 20 Jul 2020 12:35:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47465C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 363BA85660
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0LfQTgZFX2uw for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 12:35:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 63635855CE
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595248544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QyfSYuwzCMJwlPSjgt3xH5r/wR3EoTKDYmEm2e5lk4g=;
 b=Cvv34eAnF1L4bOQ5axedrrieAi9w3Qbrl4EJnfZOPrXBNFNrEjnlSB1Rr36pHKJaVasZ4R
 6lc/NXHmGTBFj218XlKo7M8vd9SqyGbrBDpo0yF5EvIx703vEi3Las2Xf4cPwVH1Xr3OkM
 u0vlF+M3sJ1u5xzOzP23jx7+vqq4cFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-L7QMf2XhPMWTg43hs6byrQ-1; Mon, 20 Jul 2020 08:35:40 -0400
X-MC-Unique: L7QMf2XhPMWTg43hs6byrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2011A1E03;
 Mon, 20 Jul 2020 12:35:38 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F15E90341;
 Mon, 20 Jul 2020 12:35:28 +0000 (UTC)
Subject: Re: [PATCH v5 13/15] vfio/pci: Expose PCIe PASID capability to guest
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-14-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <63d4c058-246d-1a11-af66-e97fd5ec9bd3@redhat.com>
Date: Mon, 20 Jul 2020 14:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594552870-55687-14-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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

Yi,

On 7/12/20 1:21 PM, Liu Yi L wrote:
> This patch exposes PCIe PASID capability to guest for assigned devices.
> Existing vfio_pci driver hides it from guest by setting the capability
> length as 0 in pci_ext_cap_length[].
> 
> And this patch only exposes PASID capability for devices which has PCIe
> PASID extended struture in its configuration space. So VFs, will will
s/will//
> not see PASID capability on VFs as VF doesn't implement PASID extended
suggested rewording: VFs will not expose the PASID capability as they do
not implement the PASID extended structure in their config space?
> structure in its configuration space. For VF, it is a TODO in future.
> Related discussion can be found in below link:
> 
> https://lkml.org/lkml/2020/4/7/693

> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
> v1 -> v2:
> *) added in v2, but it was sent in a separate patchseries before
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index d98843f..07ff2e6 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -95,7 +95,7 @@ static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
>  	[PCI_EXT_CAP_ID_LTR]	=	PCI_EXT_CAP_LTR_SIZEOF,
>  	[PCI_EXT_CAP_ID_SECPCI]	=	0,	/* not yet */
>  	[PCI_EXT_CAP_ID_PMUX]	=	0,	/* not yet */
> -	[PCI_EXT_CAP_ID_PASID]	=	0,	/* not yet */
> +	[PCI_EXT_CAP_ID_PASID]	=	PCI_EXT_CAP_PASID_SIZEOF,
>  };
>  
>  /*
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
