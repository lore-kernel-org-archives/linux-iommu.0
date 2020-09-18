Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC2C43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 09:44:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967BF21D7F
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 09:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967BF21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3AE902E1F2;
	Fri, 18 Sep 2020 09:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ba7ph8VnhEXE; Fri, 18 Sep 2020 09:44:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DB9BC2E1C2;
	Fri, 18 Sep 2020 09:44:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEB6BC0859;
	Fri, 18 Sep 2020 09:44:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 407FAC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2632A877D4
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:44:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cs-Wh+toI2Bu for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 09:44:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8E964877CD
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:44:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 00962293; Fri, 18 Sep 2020 11:44:51 +0200 (CEST)
Date: Fri, 18 Sep 2020 11:44:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v9 3/7] iommu/uapi: Introduce enum type for PASID data
 format
Message-ID: <20200918094450.GP31590@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Wu Hao <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Yi Sun <yi.y.sun@intel.com>
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

On Fri, Sep 11, 2020 at 02:57:52PM -0700, Jacob Pan wrote:
> There can be multiple vendor-specific PASID data formats used in UAPI
> structures. This patch adds enum type with a last entry which makes
> range checking much easier.

But it also makes it much easier to screw up the numbers (which are ABI)
by inserting a new value into the middle. I prefer defines here, or
alternativly BUILD_BUG_ON() checks for the numbers.

Regards,

	Joerg

> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index b42acc8fe007..7cc6ee6c41f7 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -298,11 +298,16 @@ struct iommu_gpasid_bind_data_vtd {
>  					 IOMMU_SVA_VTD_GPASID_PCD |  \
>  					 IOMMU_SVA_VTD_GPASID_PWT)
>  
> +enum iommu_pasid_data_format {
> +	IOMMU_PASID_FORMAT_INTEL_VTD = 1,
> +	IOMMU_PASID_FORMAT_LAST,
> +};
> +
>  /**
>   * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
>   * @argsz:	User filled size of this data
>   * @version:	Version of this data structure
> - * @format:	PASID table entry format
> + * @format:	PASID table entry format of enum iommu_pasid_data_format type
>   * @flags:	Additional information on guest bind request
>   * @gpgd:	Guest page directory base of the guest mm to bind
>   * @hpasid:	Process address space ID used for the guest mm in host IOMMU
> @@ -321,7 +326,6 @@ struct iommu_gpasid_bind_data {
>  	__u32 argsz;
>  #define IOMMU_GPASID_BIND_VERSION_1	1
>  	__u32 version;
> -#define IOMMU_PASID_FORMAT_INTEL_VTD	1
>  	__u32 format;
>  	__u32 addr_width;
>  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> -- 
> 2.7.4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
