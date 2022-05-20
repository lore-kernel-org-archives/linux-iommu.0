Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE48C433F5
	for <iommu@archiver.kernel.org>; Sat, 21 May 2022 00:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C36F2411B7;
	Sat, 21 May 2022 00:06:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 56HdIF-hw9x3; Sat, 21 May 2022 00:06:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F31B4015E;
	Sat, 21 May 2022 00:06:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 281A6C007F;
	Sat, 21 May 2022 00:06:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC174C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C54CE4194B
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=wdc.com header.b="DswjfxU5";
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.b="YHZ5Bmgq"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L0r3pyNY7ag1 for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 23:32:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6141418F2
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653089553; x=1684625553;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nlqrTymAHeI9jw2VarrArEVOw1HPczPiwh10VKEkDxg=;
 b=DswjfxU5Vee2rYIDpWs495JPT61JwL/MGesl5FUYI13637eenaKO9xK8
 IQb75Xj7KD8+caKRqiIEAKTsFDnrOwmmbhOpdPr1L5w29yd5dznsGvlKu
 1o/Nw+PEXAatJNpeNRBu2UzR7QdPT/vNqxeA3R0ycB1wuY/PJkeyPoYVi
 uXPvzMv28xp/nDtNTRVMxyVDFnUrEwOLq06XZMCz0bc8i+H6sJg1NzTkn
 rpEu3D5F5SnY801SZoTV9763BbDu8EyXkTnPIREdpYjU6rViAuXxDu4+Y
 bDAZVJbEvicaCyX8Xdc8uRptlj/vCnA9iJ6+gEl8ZGAxYTDuLTLhvqK77 A==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; d="scan'208";a="305178286"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:32:32 +0800
IronPort-SDR: zbJqe6owraSs9RgMNeOWVeumehveq016vJYN5u/USqUMYGGh5SjgkHI9CtCFSFyTMss4jYoRiH
 Yy1WZyteYs3vOM3B5yQ5JrdC0vB729o12iASl/QWrGiZWrfhJiSCQNv2ZhiX5B0CKaeolPN7Go
 LYheu7B90q2RAKgtbX4Fk3TjalB6O5Y5KjyWUQa9e0KZGxmQSIlKFKj7G099UxL/28vFNkzspD
 ATTVuTVttdSnvWrSOOUJ6pGSPWB5g6ZHjp0Ycj4WU4y5Ep9qi1SfTwbIk/16H6j2lN0YmiSCXl
 PEPW16kEyqggwZl7d4R0qJCp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 May 2022 15:55:16 -0700
IronPort-SDR: T49c2kF8UTZARN7TU3yVrXv4rFgIELTi5w8O8UqPPeb+jA5Azwb3brdiXev2wj93u7sFH8gSN8
 8WylKC5pJmWfUCdaaNm4HeQ6kFX9gZYO7G7S1UczqypuXRQtjYe5JiNzuy5wC6p+M9g+iBPuxx
 7APNRiIIGGiHb/5aTncSXWNgr2QxvvXJygtHYFsC1nQVh6EksHb638sq4HEBPs7vdJGaq0gwSO
 mIEh+HbAztn8636yd8UMQ/6/xAvxx+dICxVbhkpWFcaRdvlCv++TnvvUf94X2sk9kJtpG+gO4Y
 tKI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 May 2022 16:32:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jgg4qJ5z1SHwl
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 16:32:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653089550; x=1655681551; bh=nlqrTymAHeI9jw2VarrArEVOw1HPczPiwh1
 0VKEkDxg=; b=YHZ5BmgqYv9FN9mO8XurnpEauFCHjmNMztVvz5Ngla7RcKTpFX/
 d5Z0DgDFF1o7DbE4cmN2PXdfmlJ6X8bacxoTi3YTsy3xByPM3l++fuxuxJODGPii
 nLlGYqxF2N3rTaaAOPDzcPGrDvIiK43ijfcdvmQ+5y8zXimy3E1GzVkd6CuCNbZ7
 S7GxYZcDQAp9A3jvc1mDJhMnKgZ4tLVpAca8InfMOHmhgMs+8XY2oNEWP8i2z0rj
 OwNzyG5PccZCTP5qlx4yWhl7C98xqZr+gOIOoH8pKpSSiBxRcIBO0jhSeMXMTV0c
 14TVkdKTBIkCHtorF74gUuBos8eP2mHAD6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id N5cu9J2ladBG for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 16:32:30 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jgc191Pz1Rvlc;
 Fri, 20 May 2022 16:32:27 -0700 (PDT)
Message-ID: <8f46233b-9905-c35b-0d27-00c9af729195@opensource.wdc.com>
Date: Sat, 21 May 2022 08:32:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] dma-mapping: Add dma_opt_mapping_size()
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-2-git-send-email-john.garry@huawei.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-2-git-send-email-john.garry@huawei.com>
X-Mailman-Approved-At: Sat, 21 May 2022 00:06:20 +0000
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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
From: Damien Le Moal via iommu <iommu@lists.linux-foundation.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 5/20/22 17:23, John Garry wrote:
> Streaming DMA mapping involving an IOMMU may be much slower for larger
> total mapping size. This is because every IOMMU DMA mapping requires an
> IOVA to be allocated and freed. IOVA sizes above a certain limit are not
> cached, which can have a big impact on DMA mapping performance.
> 
> Provide an API for device drivers to know this "optimal" limit, such that
> they may try to produce mapping which don't exceed it.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  Documentation/core-api/dma-api.rst |  9 +++++++++
>  include/linux/dma-map-ops.h        |  1 +
>  include/linux/dma-mapping.h        |  5 +++++
>  kernel/dma/mapping.c               | 12 ++++++++++++
>  4 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index 6d6d0edd2d27..b3cd9763d28b 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -204,6 +204,15 @@ Returns the maximum size of a mapping for the device. The size parameter
>  of the mapping functions like dma_map_single(), dma_map_page() and
>  others should not be larger than the returned value.
>  
> +::
> +
> +	size_t
> +	dma_opt_mapping_size(struct device *dev);
> +
> +Returns the maximum optimal size of a mapping for the device. Mapping large
> +buffers may take longer so device drivers are advised to limit total DMA
> +streaming mappings length to the returned value.
> +
>  ::
>  
>  	bool
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 0d5b06b3a4a6..98ceba6fa848 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -69,6 +69,7 @@ struct dma_map_ops {
>  	int (*dma_supported)(struct device *dev, u64 mask);
>  	u64 (*get_required_mask)(struct device *dev);
>  	size_t (*max_mapping_size)(struct device *dev);
> +	size_t (*opt_mapping_size)(void);
>  	unsigned long (*get_merge_boundary)(struct device *dev);
>  };
>  
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index dca2b1355bb1..fe3849434b2a 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -144,6 +144,7 @@ int dma_set_mask(struct device *dev, u64 mask);
>  int dma_set_coherent_mask(struct device *dev, u64 mask);
>  u64 dma_get_required_mask(struct device *dev);
>  size_t dma_max_mapping_size(struct device *dev);
> +size_t dma_opt_mapping_size(struct device *dev);
>  bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
>  unsigned long dma_get_merge_boundary(struct device *dev);
>  struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
> @@ -266,6 +267,10 @@ static inline size_t dma_max_mapping_size(struct device *dev)
>  {
>  	return 0;
>  }
> +static inline size_t dma_opt_mapping_size(struct device *dev)
> +{
> +	return 0;
> +}
>  static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>  {
>  	return false;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index db7244291b74..1bfe11b1edb6 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -773,6 +773,18 @@ size_t dma_max_mapping_size(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>  
> +size_t dma_opt_mapping_size(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	size_t size = SIZE_MAX;
> +
> +	if (ops && ops->opt_mapping_size)
> +		size = ops->opt_mapping_size();
> +
> +	return min(dma_max_mapping_size(dev), size);
> +}
> +EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
> +
>  bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
