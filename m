Return-Path: <SRS0=3WiH=XL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC83CC49ED7
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 09:14:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD1E206A4
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 09:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD1E206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BB86F12A3;
	Mon, 16 Sep 2019 09:14:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8697312C8;
	Mon, 16 Sep 2019 09:14:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3F6C8832;
	Mon, 16 Sep 2019 09:14:27 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79B2B102BB32;
	Mon, 16 Sep 2019 09:14:26 +0000 (UTC)
Received: from [10.36.116.33] (ovpn-116-33.ams2.redhat.com [10.36.116.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C4B05D6A3;
	Mon, 16 Sep 2019 09:14:23 +0000 (UTC)
Subject: Re: [PATCH 0/5] iommu: Implement iommu_put_resv_regions_simple()
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6254f754-eb37-6b1e-deea-7443d185d49b@redhat.com>
Date: Mon, 16 Sep 2019 11:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190829111752.17513-1-thierry.reding@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
	(mx1.redhat.com [10.5.110.64]);
	Mon, 16 Sep 2019 09:14:26 +0000 (UTC)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Thierry,

On 8/29/19 1:17 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Most IOMMU drivers only need to free the memory allocated for each
> reserved region. Instead of open-coding the loop to do this in each
> driver, extract the code into a common function that can be used by
> all these drivers.

If I am not wrong, all the drivers now use the
iommu_put_resv_regions_simple helper. So we can wonder if the callback
is still relevant?

Thanks

Eric
> 
> Thierry
> 
> Thierry Reding (5):
>   iommu: Implement iommu_put_resv_regions_simple()
>   iommu: arm: Use iommu_put_resv_regions_simple()
>   iommu: amd: Use iommu_put_resv_regions_simple()
>   iommu: intel: Use iommu_put_resv_regions_simple()
>   iommu: virt: Use iommu_put_resv_regions_simple()
> 
>  drivers/iommu/amd_iommu.c    | 11 +----------
>  drivers/iommu/arm-smmu-v3.c  | 11 +----------
>  drivers/iommu/arm-smmu.c     | 11 +----------
>  drivers/iommu/intel-iommu.c  | 11 +----------
>  drivers/iommu/iommu.c        | 19 +++++++++++++++++++
>  drivers/iommu/virtio-iommu.c | 14 +++-----------
>  include/linux/iommu.h        |  2 ++
>  7 files changed, 28 insertions(+), 51 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
