Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94576C2BA19
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 12:31:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675AF2074F
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 12:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675AF2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 39F0A86581;
	Wed, 15 Apr 2020 12:31:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tib+0Zhi52tw; Wed, 15 Apr 2020 12:31:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4358E86356;
	Wed, 15 Apr 2020 12:31:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23BA9C1D8D;
	Wed, 15 Apr 2020 12:31:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C25ACC0172;
 Wed, 15 Apr 2020 12:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B980B85629;
 Wed, 15 Apr 2020 12:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CFsYRzBb1OXj; Wed, 15 Apr 2020 12:31:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0F7708560E;
 Wed, 15 Apr 2020 12:31:45 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C7A69AC11;
 Wed, 15 Apr 2020 12:31:41 +0000 (UTC)
Date: Wed, 15 Apr 2020 14:31:40 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 07/33] iommu: Add probe_device() and remove_device()
 call-backs
Message-ID: <20200415123140.GC21899@suse.de>
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200414131542.25608-8-joro@8bytes.org>
 <0ad37581-b464-30ac-c503-4c0daaf43867@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ad37581-b464-30ac-c503-4c0daaf43867@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Heiko Stuebner <heiko@sntech.de>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
 Andy Gross <agross@kernel.org>, linux-s390@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, Apr 15, 2020 at 02:36:20PM +0800, Lu Baolu wrote:
> On 2020/4/14 21:15, Joerg Roedel wrote:
> > From: Joerg Roedel<jroedel@suse.de>
> > 
> > Add call-backs to 'struct iommu_ops' as an alternative to the
> > add_device() and remove_device() call-backs, which will be removed when
> > all drivers are converted.
> > 
> > The new call-backs will not setupt IOMMU groups and domains anymore,
> > so also add a probe_finalize() call-back where the IOMMU driver can do
> > per-device setup work which require the device to be set up with a
> > group and a domain.
> 
> The subject is inaccurate. probe_device() and release_device() are
> added to replace the add and remove pair.

This patch does not replace them yet, it just adds the new call-backs.
The removal of add_device()/remove_device() happens later in the
patch-set when all drivers are converted.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
