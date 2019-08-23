Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1D5C3A5A2
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 07:50:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FF422CEC
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 07:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQWM/EOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FF422CEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AF02ADAF;
	Fri, 23 Aug 2019 07:50:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1E357C77
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 07:50:33 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0733EE6
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 07:50:32 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 924B322CE3;
	Fri, 23 Aug 2019 07:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566546631;
	bh=QGB1QBbRBrvFJ0/ORqHfkbvDtYwROh22ycSAYGYaOko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQWM/EOSnXMuyItw5blNA1dLPvsG9tdgOjJwfMILly3AcaU7CRSxARkh8ZDSpDlqt
	dHAT8oq0KUFejzdqkF502yLNsk25p7Tp/O48oKVoQNwPOq5s1xI9pqTKG7kczP9vat
	7EunzJrmSyE8pluvsRyanF/+guAD9slGOQ8zl0dE=
Date: Fri, 23 Aug 2019 08:50:27 +0100
From: Will Deacon <will@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v3 0/2] improve the concurrency of
	arm_smmu_atc_inv_domain()
Message-ID: <20190823075026.pwlx33e4crh3m6tn@willie-the-truck>
References: <20190823024551.24448-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190823024551.24448-1-thunder.leizhen@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Fri, Aug 23, 2019 at 10:45:49AM +0800, Zhen Lei wrote:
> v2 --> v3:
> As Will Deacon's suggestion, I changed the lock type of
> arm_smmu_domain.devices_lock from spinlock_t to rwlock_t, and I saw that the
> performance is all right. And further use nr_ats_masters to quickly check have
> no obvious effect, so I drop it.

:/

I already sent two versions of a series fixing this without any locking at
all on the ->unmap() path, and you were on cc. I've also queued that stuff
up.

Did you not receive my patches?

v1: https://lists.linuxfoundation.org/pipermail/iommu/2019-August/038306.html
v2: https://lists.linuxfoundation.org/pipermail/iommu/2019-August/038374.html

Queued: https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/smmu-v3

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
