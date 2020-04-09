Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DC7C2D0EA
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 07:11:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BE82072F
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 07:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aol.com header.i=@aol.com header.b="HvieXGvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BE82072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 330A486F9F;
	Thu,  9 Apr 2020 07:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xnbGwjcl69nh; Thu,  9 Apr 2020 07:11:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 54AB186FFF;
	Thu,  9 Apr 2020 07:11:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF93C1D7E;
	Thu,  9 Apr 2020 07:11:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD9F9C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 00:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A75A685C90
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 00:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QZCheSfFl76o for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 00:51:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from sonic315-48.consmr.mail.ne1.yahoo.com
 (sonic315-48.consmr.mail.ne1.yahoo.com [66.163.190.174])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8CB04809F3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 00:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1586393513; bh=/6EYCRlfa2umBwyf6HMqnS88iYA4EIXadLKaqqSMGXc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=HvieXGvbwHIVIK/gYKQ1lC4pzEkccIoUtFVCXKQJQyyr9anzfAW4kR7cdzHKQVNdwKv2LwnplwjrD0aQkxt9HvZDnn0uRd9Jv6iSywy0mJFsQxB7g1WWgMN24xWmdS8GH+Id1lAeviwVAS624VUdgJOtK4L566xJwPjUiHuettyW8dE3sEmWtm4sMt5IL1ChkMHC+w6Bdr4Li8wh6mU9LmIoV/4GDMCB24Z6Ty2aJCnlNjtwzQWnhd2D07pQK7rk5fpC4u5SpSrA/nKGFxKgnZ54pp3f2NruS1R0bo8EPEXa754Eg/5Uww55uIFzHYKa9LpN3Co6H2k2pwG2l4jzcg==
X-YMail-OSG: Kjs_hFQVM1mYR3Bbv__auOf2fhoaIk9dbexLkMUvZvDcgibPrEIH2uN_nb7TSk.
 AjTVDttprz38pf2agkDENCO9OlpstM6AKa5fqJSzz9g9BDnD9cEKZ6Kcqg9CatwzLNYThMuSUeYX
 2yEgN2U8e5xgtZHtWmAFsIbznPJD_UPhljYJl2r_EoL5qqrqeJu9Nnd9Y.Ff.0cQ6SO_SlnVXMbj
 JYEgiFEkwq6TWViREF0oZDh5a7V1WTHk_fQL7mKo.zfkeUUkf9r2PC3YbrlM36YDrBNE7Vu_H_23
 7SUm_oYUdCkn.imVzOSTsbg1UKej12C_c6DVKmb2bShJF7ckagBec7h.F7Pz2jADVU.RAf_SzeRw
 jnXQU.OYwZs7DtYvRPtgjcVfmgAxeq8RUp0VPoOeRchdyRoGHKkYEH1l0ufQv3CAgRqC9S3zsOd9
 fnhObZjDMfX58eXYxHjcxjHRReqFOhx5Hz6aq8FIq7jw8y8OEbWPMrjaCpR4FKEn_bozdR4qyDFm
 4sbsu66FrZifwa3kj9UeUr.wGSL5S042VmSyGfETFpHOTRvx51GHTkDHF4kqnnRQjnt9cOY_TXoy
 6ikjZzl8Rym8MnuDSY3t2UEnyXfrQM8zmKcZMaBXZA.1JruNMW__SZDUsuarZwJACQIZFjYaEYcB
 6Fx2cC_OXlNG7d102FBbLxbbWE51eCCn6.Ao3BUdftIqkSfQqE8AmEChvpnb3Hjczsgr87hSe_ZY
 FNPGuabtMxRjTV5vOhJN9EVsFZjNMIpNdxApHaOp9BBa0mK8Hd4Y8_sLLzgFE_OX._p_ww8OgQCS
 _PZw5TJANZTRxfmtlnIT9WY8nJxFEz0ZzkRbyJrD7lBRVCuL2qRMMrbnVCU.d3atpGGNT71.FMTl
 XJp9kOjDwdiPhEHaNTf0wy9.286eHx9hDHZx13ycI4lCw.BNZVla9tTflJZSkBR622oDAvju0pYi
 chnjA_f0d_Rs3Y.w_0UWDDtsiqrp7Nd.ENOvnjBk3WtBBjbeqzYHxInpU0ICw.akO5xUiF4HXGRD
 NGu7bFyqgIPHiVSYVkpfC.PnR3fZmrfgYy1Ktc5D_y5Xh2Z7vFADl5LC6uRiCqJ9Y4yLuHo1ATrn
 PxNppKa486Nn86yT5d.pKQ3q49VQAxNEB7EGZ_QmK0uyT9X6oF2qpuwBBPhXWKUMiK3EbPuATGVw
 L.4MdTecfHCHslUWJtwrtw2v46CslPDJY3TtzPBEF3b6hKOBHSxZ.8CqTxF3S2_xcA64udxpFdja
 9c_vKNU82cTswpLxDeBimIz._J7Xaum1i6dZEwCbc.uspehQ3L04kL45bX0fhpi7dDoUJat5aE3S
 p_Fl8AHbSq3P.bkBJGmoklW4vRdsCXSUz4v5SYoPxJ86d1eVDsQ0qrpylWpfgRvkXgRw467FBrzC
 _ECRk3ijYTNyDsC7idxPty4i4XJSa9KM2uH5RWvaV.R8phY0hHU.lO54DG8mygB9TxdZscMBwbtP
 JqFlYvAh9BGSO_QyxpGrs
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Apr 2020 00:51:53 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 07bc1f76d2033b5244ea2e327c66bf87; 
 Thu, 09 Apr 2020 00:39:51 +0000 (UTC)
Date: Thu, 9 Apr 2020 08:39:35 +0800
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 17/28] mm: remove the prot argument from vm_map_ram
Message-ID: <20200409003931.GA8418@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-18-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-18-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15620 hermes Apache-HttpAsyncClient/4.1.4
 (Java/11.0.6)
X-Mailman-Approved-At: Thu, 09 Apr 2020 07:11:24 +0000
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>,
 linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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
From: Gao Xiang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Apr 08, 2020 at 01:59:15PM +0200, Christoph Hellwig wrote:
> This is always GFP_KERNEL - for long term mappings with other properties
> vmap should be used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c   | 2 +-
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 3 +--
>  drivers/media/common/videobuf2/videobuf2-vmalloc.c | 3 +--
>  fs/erofs/decompressor.c                            | 2 +-

For EROFS part,

Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
