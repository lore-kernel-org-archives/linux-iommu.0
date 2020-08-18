Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5ECC433DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 09:45:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02998206B5
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 09:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AkaISKol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02998206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CCC4185C19;
	Tue, 18 Aug 2020 09:45:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88zfKNQ7AGL7; Tue, 18 Aug 2020 09:45:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2347C85C13;
	Tue, 18 Aug 2020 09:45:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05F95C07FF;
	Tue, 18 Aug 2020 09:45:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E91BC0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 09:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 47E0E85C19
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 09:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I+xTIYN-8Bxp for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 09:45:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5178985C13
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 09:45:15 +0000 (UTC)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20200818094512epoutp015d5b8496a1c7ef85c1d81cdc996f2ad7~sU5_SSTVD2167321673epoutp010
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 09:45:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20200818094512epoutp015d5b8496a1c7ef85c1d81cdc996f2ad7~sU5_SSTVD2167321673epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1597743912;
 bh=NsOkvQvkZldczEqoWc3iM/DpfiYCpCE0mDSOoCg/0iU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AkaISKoluwZ6XYRe1HTd/8+1jaQhi6NA0CA2ARIsJqx+l/CCoRD3+++00Xgwch6AL
 ARX2acvYLPtF2EiaPIhJ10lfbPPpMhpeA+vlrEmmTY7a1AvvTICCgrRMIVTN+ipNOY
 3yRDJE699gU2M5OrqF8GJYptNnse7Z0o5yJ6uEFA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20200818094511epcas2p474d123ae164af4eb831076642f6ee69a~sU59Ogbj72342323423epcas2p4X;
 Tue, 18 Aug 2020 09:45:11 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.188]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4BW5cP3FYBzMqYkZ; Tue, 18 Aug
 2020 09:45:09 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 36.FA.19322.523AB3F5; Tue, 18 Aug 2020 18:45:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20200818094508epcas2p418f7d4eb9bb6ca3f41cac4529c6d0942~sU565tFYa2340623406epcas2p4U;
 Tue, 18 Aug 2020 09:45:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200818094508epsmtrp1fc688000405a3e1ef8637970e1e77fa3~sU564_uyd2407924079epsmtrp1A;
 Tue, 18 Aug 2020 09:45:08 +0000 (GMT)
X-AuditID: b6c32a45-797ff70000004b7a-b3-5f3ba32518b2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 0E.97.08303.423AB3F5; Tue, 18 Aug 2020 18:45:08 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20200818094508epsmtip206c9cca6a2cc76d1706f68fa73ae5f6b~sU56vFHRz2251022510epsmtip2U;
 Tue, 18 Aug 2020 09:45:08 +0000 (GMT)
Date: Tue, 18 Aug 2020 18:37:39 +0900
From: Cho KyongHo <pullip.cho@samsung.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200818093739.GB191752@KEI>
MIME-Version: 1.0
In-Reply-To: <20200818082852.GA15145@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmma7qYut4g/8HxCzeL+thtPjbeYHV
 YsF+a4vNc4otOmdvYLfY9Pgaq8XlXXPYLNYeuctucfDDE1aLljumDlweTw7OY/JYM28No8em
 VZ1sHpuX1HtMvrGc0aNvyypGj8+b5ALYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
 DS0tzJUU8hJzU22VXHwCdN0yc4BuU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
 GBoW6BUn5haX5qXrJefnWhkaGBiZAlUm5GTMX3aNtaBZsGLBu83MDYzveLsYOTkkBEwkFu/f
 wt7FyMUhJLCDUeLI8x5mCOcTo8S0bXOhMp8ZJXbdvczSxcgB1tJ9KBOkW0hgF6PEoZW2EDUP
 GSV+3fjKCJJgEVCVWHq8kxnEZhPQklg99zhYXERAUWLH9j9gG5gFfjFK3Fj4mwUkISzgLbFm
 RTMTiM0roClxeEMbG4QtKHFy5hOwGk4BM4mT7d1MIEeICqhIvDpYDzJHQmAuh8S0ubeZIP5x
 keh5uYYFwhaWeHUc5DcQW0riZX8bO0TDdEaJd/MPsUEkNjNKfNstCGEbS8x61g52KbNAhsTT
 Z7ugPlaWOHKLBSLMJ9Fx+C87RJhXoqNNCKJTRWLn1GssMKv69t6A6vSQ+DtRCBJWxxglXi1N
 nsAoPwvJY7OQ7IKwdSQW7P7ENguom1lAWmL5Pw4IU1Ni/S79BYysqxjFUguKc9NTi40KDJGj
 ehMjONVque5gnPz2g94hRiYOxkOMEhzMSiK8SSfM44V4UxIrq1KL8uOLSnNSiw8xmgKjaSKz
 lGhyPjDZ55XEG5oamZkZWJpamJoZWSiJ8+YqXogTEkhPLEnNTk0tSC2C6WPi4JRqYMotOWxj
 LvEmxeXZh+xlHltCH2fbrLhs7jat+OpGKY6vASYce1Zovz/cMT31m8F1u2tlu6Uyu81+KpzU
 N7V4PvH+K42c5h2npPt0FpoWHd0X0TIxQK3v8eUaxs8l7PMYTsy+tW5eo/iV2GPl+gUiDRPV
 8+LjMnOLxTWePPWLeNnCah3ZI8+x5JbPjD96Z6beXeJSdrJGNvcKm8O1TN9HVyfLsTvlbLZ9
 tvn2t8JrXfFz3/39ZXe+KsndcGsDR9m6utP70i6erPwkt5sjs4Hz+YYtHUU/T6qqG8o8Vvcv
 UohMeGMcKtunEjKjmuM9i/KMddXq20zeZ5i/de1jFlRZMHVJ1ZcSC/bGiMURdjt3KLEUZyQa
 ajEXFScCALBJtCg+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK7KYut4g73fzS3eL+thtPjbeYHV
 YsF+a4vNc4otOmdvYLfY9Pgaq8XlXXPYLNYeuctucfDDE1aLljumDlweTw7OY/JYM28No8em
 VZ1sHpuX1HtMvrGc0aNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgyDr+vLDjMV3FmQk4D43Hu
 LkYODgkBE4nuQ5ldjJwcQgI7GCW2TJIDsSUEpCTmda9lgrCFJe63HGHtYuQCqrnPKDGxZRU7
 SIJFQFVi6fFOZhCbTUBLYvXc44wgtoiAosSO7X+YQRqYBf4wSjw8eh+sQVjAW2LNimawqbwC
 mhKHN7SxQUw9xihx9e5/doiEoMTJmU9YQGxmoKk3/r1kArmUWUBaYvk/DpAwp4CZxMn2brCw
 qICKxKuD9RMYBWchaZ6FpHkWQvMCRuZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjB
 caKltYNxz6oPeocYmTgYDzFKcDArifAmnTCPF+JNSaysSi3Kjy8qzUktPsQozcGiJM77ddbC
 OCGB9MSS1OzU1ILUIpgsEwenVAOThE2UCsexQt3iVy2vw2d+7oj0vNy1poP12T8/PQVW62hb
 i9t11cFesh+FrNxydx3tudxib7Pe8YcaU/wOsfmHTl+5mL/a5cZHv5lGk11Wh3Smqr10YhXh
 vLVqitbb9eKO1w3jb6peZzxZcuPWeblXpTrLZqV4TcqRf2jNEHBzL7t+4KKouUfPrNQq7ZH8
 vfDw24hHN3/F9iza8+XfBh77JC028YAnZzd3v94TZru+yMJ2/pxT/fqqq59ohL3i2BW6PYp/
 xXk/YeZyv9srs3Nj6o4v0+q1midqd86H0+hoZfQsnnm/zMOs77KF/Iion3TduudbjZHK2y9+
 1iqbRAXK2D9t3bpI4VnnchexA4xKLMUZiYZazEXFiQCwYQjgAgMAAA==
X-CMS-MailID: 20200818094508epcas2p418f7d4eb9bb6ca3f41cac4529c6d0942
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_29efc_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
 <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
 <20200818082852.GA15145@willie-the-truck>
Cc: janghyuck.kim@samsung.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, hyesoo.yu@samsung.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_29efc_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Aug 18, 2020 at 09:28:53AM +0100, Will Deacon wrote:
> On Tue, Aug 18, 2020 at 04:43:10PM +0900, Cho KyongHo wrote:
> > Cache maintenance operations in the most of CPU architectures needs
> > memory barrier after the cache maintenance for the DMAs to view the
> > region of the memory correctly. The problem is that memory barrier is
> > very expensive and dma_[un]map_sg() and dma_sync_sg_for_{device|cpu}()
> > involves the memory barrier per every single cache sg entry. In some
> > CPU micro-architecture, a single memory barrier consumes more time than
> > cache clean on 4KiB. It becomes more serious if the number of CPU cores
> > are larger.
> 
> Have you got higher-level performance data for this change? It's more likely
> that the DSB is what actually forces the prior cache maintenance to
> complete,

This patch does not skip necessary DSB after cache maintenance. It just
remove repeated dsb per every single sg entry and call dsb just once
after cache maintenance on all sg entries is completed.

> so it's important to look at the bigger picture, not just the
> apparent relative cost of these instructions.
> 
If you mean bigger picture is the performance impact of this patch to a
complete user scenario, we are evaluating it in some latency sensitve
scenario. But I wonder if a performance gain in a platform/SoC specific
scenario is also persuasive.

> Also, it's a miracle that non-coherent DMA even works,

I am sorry, Will. I don't understand this. Can you let me know what do
you mena with the above sentence?

> so I'm not sure
> that we should be complicating the implementation like this to try to
> make it "fast".
> 
I agree that this patch makes the implementation of dma API a bit more
but I don't think this does not impact its complication seriously.

> Will
> 

Thank you.

------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_29efc_
Content-Type: text/plain; charset="utf-8"


------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_29efc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_29efc_--
