Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2887C433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 13:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 454D660BB4;
	Mon, 27 Jun 2022 13:13:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 454D660BB4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gUEh+UYZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2VQATKc-FyVE; Mon, 27 Jun 2022 13:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E2A260590;
	Mon, 27 Jun 2022 13:13:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E2A260590
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC41EC0032;
	Mon, 27 Jun 2022 13:13:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19A51C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 13:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8B7383EDC
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 13:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8B7383EDC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=gUEh+UYZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IDka6OnPVCK0 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 13:13:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9FBC8343E
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9FBC8343E
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 13:13:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 732C1612C6;
 Mon, 27 Jun 2022 13:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5371CC3411D;
 Mon, 27 Jun 2022 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1656335579;
 bh=KxQd/s6GCe+NWcPsgCZLFK40rFPNf7a/wVIlViwbl/I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gUEh+UYZFfTXjVnNUnlNcOW6TiNlpvYR6c3SYIMVThWGemiWEGEzMvdDuSxWO2hlj
 69sOlsqRfkx2RuVENH9MRUFO2zGzns88JJdOf2BTZVkhsXlYPPh812OROviwzDp2+H
 3C8oLJU8WSEzjKAw4LjOosUp8Y1Rbj4AHKuCotU8=
Date: Mon, 27 Jun 2022 15:12:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yicong Yang <yangyicong@huawei.com>
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
Message-ID: <Yrms2cI05O2yZRKU@kroah.com>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
Cc: mark.rutland@arm.com, prime.zeng@huawei.com, peterz@infradead.org,
 linux-pci@vger.kernel.org, linuxarm@huawei.com,
 Yicong Yang <yangyicong@hisilicon.com>, james.clark@arm.com, will@kernel.org,
 alexander.shishkin@linux.intel.com, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, suzuki.poulose@arm.com, acme@kernel.org,
 zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 leo.yan@linaro.org, robin.murphy@arm.com
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

On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
> Hi Greg,
> 
> Since the kernel side of this device has been reviewed for 8 versions with
> all comments addressed and no more comment since v9 posted in 5.19-rc1,
> is it ok to merge it first (for Patch 1-3 and 7-8)?

I am not the maintainer of this subsystem, so I do not understand why
you are asking me :(

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
