Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB737C433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:37:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557EB61A2C
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557EB61A2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 216CB401DE;
	Thu, 25 Mar 2021 17:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t91fTPcxniKp; Thu, 25 Mar 2021 17:37:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09456401D9;
	Thu, 25 Mar 2021 17:37:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAD48C000D;
	Thu, 25 Mar 2021 17:37:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98F36C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8751A401D9
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zMORLY__We2Q for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 17:37:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 097B840191
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:37:01 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F76561A0E;
 Thu, 25 Mar 2021 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616693821;
 bh=M2twXmtu97j9otFWI5zh//Nf5kn2DxkZlOPXyLaNlOw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L2mrJVQplXi1fO3DchQqGuhtH1RRLKh+h5UoD9SCVT+ufeR6GzNO5MqWdWmuFbgC6
 gQ8hlsWvwAkeCpHoy7mtUPzWvZeVZ0VeA/7e+GUHZAkRWdKxUr33y9JRIIt8JMzCAG
 cI3Wm4ygdcH94MuNj/rX91vO7+4+/kM+a5NBcLZo4eyzhnSEQkhCNIOjKmD4oYAOEz
 eaVl30CEfM5piQ5rGCAI0yDVa57n528Da7sCVH7Vg5YzNIHlAX6K8KlS/wamZAVDX2
 kpRtyKskGkDaV30Q18Hec+e3lV1v9nVllMWKi0P9o6qcnGOOS5JhMZEcPcpsMo74CE
 XeC+56tfazvmg==
Date: Thu, 25 Mar 2021 17:36:54 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v13 02/10] iommu/arm-smmu-v3: Use device properties for
 pasid-num-bits
Message-ID: <20210325173654.GB15504@willie-the-truck>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-3-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302092644.2553014-3-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

On Tue, Mar 02, 2021 at 10:26:38AM +0100, Jean-Philippe Brucker wrote:
> The pasid-num-bits property shouldn't need a dedicated fwspec field,
> it's a job for device properties. Add properties for IORT, and access
> the number of PASID bits using device_property_read_u32().
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/iommu.h                       |  2 --
>  drivers/acpi/arm64/iort.c                   | 13 +++++++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
>  drivers/iommu/of_iommu.c                    |  5 -----
>  4 files changed, 9 insertions(+), 14 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
