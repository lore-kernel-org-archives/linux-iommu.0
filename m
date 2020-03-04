Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1C2C3F2D1
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 21:37:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E297207FD
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 21:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E297207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 05D078462A;
	Wed,  4 Mar 2020 21:37:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xtHO8iCRilYc; Wed,  4 Mar 2020 21:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C6B6A845DF;
	Wed,  4 Mar 2020 21:37:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA896C1AE2;
	Wed,  4 Mar 2020 21:37:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF86DC013E;
 Wed,  4 Mar 2020 21:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A40102052D;
 Wed,  4 Mar 2020 21:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HPtCqPw7zt2w; Wed,  4 Mar 2020 21:37:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 9E6C72042B;
 Wed,  4 Mar 2020 21:37:47 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Mar 2020 13:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,515,1574150400"; d="scan'208";a="413294350"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost) ([10.254.51.15])
 by orsmga005.jf.intel.com with ESMTP; 04 Mar 2020 13:37:45 -0800
Date: Wed, 4 Mar 2020 13:37:44 -0800
From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200304133744.00000fdb@intel.com>
In-Reply-To: <20200304174045.GC3315@8bytes.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org> <20200304153821.GE646000@myrica>
 <20200304174045.GC3315@8bytes.org>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Rothman, 
 Michael A" <michael.a.rothman@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, jasowang@redhat.com, "Kaneda,
 Erik" <erik.kaneda@intel.com>, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 jacob.jun.pan@intel.com, bhelgaas@google.com, robin.murphy@arm.com
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

On Wed, 4 Mar 2020 18:40:46 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> On Wed, Mar 04, 2020 at 04:38:21PM +0100, Jean-Philippe Brucker wrote:
> > I agree with this. The problem is I don't know how to get a new
> > ACPI table or change an existing one. It needs to go through the
> > UEFI forum in order to be accepted, and I don't have any weight
> > there. I've been trying to get the tiny change into IORT for ages.
> > I haven't been given any convincing reason against it or offered
> > any alternative, it's just stalled. The topology description
> > introduced here wasn't my first choice either but unless someone
> > can help finding another way into ACPI, I don't have a better
> > idea.  
> 
> A quote from the ACPI Specification (Version 6.3, Section 5.2.6,
> Page 119):
> 
> 	Table signatures will be reserved by the ACPI promoters and
> 	posted independently of this specification in ACPI errata and
> 	clarification documents on the ACPI web site. Requests to
> 	reserve a 4-byte alphanumeric table signature should be sent
> to the email address info@acpi.info and should include the purpose
> 	of the table and reference URL to a document that describes
> the table format. Tables defined outside of the ACPI specification
> 	may define data value encodings in either little endian or big
> 	endian format. For the purpose of clarity, external table
> 	definition documents should include the endian-ness of their
> 	data value encodings.
> 
> So it sounds like you need to specifiy the table format and send a
> request to info@acpi.info to get a table signature for it.
> 
+ Mike and Erik who work closely on UEFI and ACPICA.

Copy paste Erik's initial response below on how to get a new table,
seems to confirm with the process you stated above.

"Fairly easy. You reserve a 4-letter symbol by sending a message
requesting to reserve the signature to Mike or the ASWG mailing list or
info@acpi.info

There is also another option. You can have ASWG own this new table so
that not one entity or company owns the new table."

> Regards,
> 
> 	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
