Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B66BC47092
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:43:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4B56139A
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 07:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4B56139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99DB14016C;
	Tue,  1 Jun 2021 07:43:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4UqUm99Qv_60; Tue,  1 Jun 2021 07:43:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C35F400C7;
	Tue,  1 Jun 2021 07:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21517C000E;
	Tue,  1 Jun 2021 07:43:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13926C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7A23607D5
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wksm9dVJhySm for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 07:43:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DC63607D4
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 07:43:41 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <daniel@iogearbox.net>)
 id 1lnyLK-0008hf-AT; Tue, 01 Jun 2021 08:57:38 +0200
Received: from [85.7.101.30] (helo=linux-2.home)
 by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1lnyLK-000OlJ-1v; Tue, 01 Jun 2021 08:57:38 +0200
Subject: Re: Regression 5.12.0-rc4 net: ice: significant throughput drop
To: robin.murphy@arm.com, jroedel@suse.de
References: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cc58c09e-bbb5-354a-2030-bf8ebb2adc86@iogearbox.net>
Date: Tue, 1 Jun 2021 08:57:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26187/Mon May 31 13:15:33 2021)
Cc: Jussi Maki <joamaki@gmail.com>, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, hch@lst.de, iommu@lists.linux-foundation.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 bpf <bpf@vger.kernel.org>, davem@davemloft.net
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[ ping Robin / Joerg, +Cc Christoph ]

On 5/28/21 10:34 AM, Jussi Maki wrote:
> Hi all,
> 
> While measuring the impact of a kernel patch on our lab machines I stumbled upon
> a performance regression affecting the 100Gbit ICE nic and bisected it
> from range v5.11.1..v5.13-rc3 to the commit:
> a250c23f15c2 iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE
> 
> Both recent bpf-next (d6a6a55518) and linux-stable (c4681547bc) are
> affected by the issue.
> 
> The regression shows as a significant drop in throughput as measured
> with "super_netperf" [0],
> with measured bandwidth of ~95Gbps before and ~35Gbps after:
> 
> commit 3189713a1b84 (a250c23^):
> $ ./super_netperf 32 -H 172.18.0.2 -l 10
> 97379.8
> 
> commit a250c23f15c2:
> $ ./super_netperf 32 -H 172.18.0.2 -l 10
> 34097.5
> 
> The pair of test machines have this hardware:
> CPU: AMD Ryzen 9 3950X 16-Core Processor
> MB: X570 AORUS MASTER
> 0a:00.0 Ethernet controller [0200]: Intel Corporation Ethernet
> Controller E810-C for QSFP [8086:1592] (rev 02)
> Kernel config: https://gist.github.com/joamaki/9ee11294c78a8dd2776041f67e5620e7
> 
> [0] https://github.com/borkmann/stuff/blob/master/super_netperf
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
