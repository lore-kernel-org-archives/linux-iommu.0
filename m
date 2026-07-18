Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702072BEC5F
	for <iommu@lists.linux.dev>; Sat, 18 Jul 2026 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344429; cv=none; b=o7Wnb/aUIkZY2GveTrB6Bi65eCAJ6iwMZSmN31eUsPiXqrEMVsALanasoKYJseZ2P/Eyq6m4KzGS/fdBO9Jh0pZ7XvzuT684KUpP/2qTVOtq/0h5Oun4OQQdFeYxYhn/SZCim6C+XjLNSnqTTx2k1A70jfiMp8GL7umGp98zjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344429; c=relaxed/simple;
	bh=/c2KdlXPq8uQryzXq7B/jdkuwAtn+b4yUbc4F3ytHgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIvt7s809dq4f5e++R4bO208a6nf0D6Qbg4nZvXb0l85jeBoqjO7k0QorGkQTuK7+w03Z9r04BtHP6zLDNzrgCeAujSfHP8QpWvGVQ5DYzX/Yw2bTkzX0ZmFuY0rsahgZh29L6ZT7fvaTPHHz2LzfRLm/6nrJWdl7D2+wmFDi4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=ImTZVw3t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YnLwGgyC; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ImTZVw3t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnLwGgyC"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 64F9D1380333;
	Fri, 17 Jul 2026 23:13:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 17 Jul 2026 23:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784344427; x=
	1784348027; bh=dBBJ1bbYoAzjdUY7u3ln2vHxvkn+rSX00R1jTCDwEPY=; b=I
	mTZVw3tCoMfDmx34w3CnyD5vGUaVNX4eXiOR/1tRpFMS+4XQRkSmSMNKTqQ26gU3
	zpp1AxlcJ/xFJ2A83FDu3STgyKy95WxXyC6Fyj3B2G6/O3WW9X+N7PWZQB7bmy4t
	KhK+Ag+FzpPYp8oHeJC9j0wEW0Bc9+qAcURE7/gWzdga9Q/GAWJFxdJ9lWj84G2k
	jxOOyDjNexpScRTTPiJretlI9pFGmvQQaFW+FitJ84j2QtNd5xzTJlvYNuQgQBxb
	9YalzkLCOcp4QkO+TsWiDlmmdsc8LLLSy7AhudYP32XHZV8SoqEj/A/rGSmcDA4D
	QgOPK1my6tHp6Du6RCO/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784344427; x=1784348027; bh=d
	BBJ1bbYoAzjdUY7u3ln2vHxvkn+rSX00R1jTCDwEPY=; b=YnLwGgyCY1CHjMUyl
	4v8YMgYFDg8fbKVQWlbOU8cLzWhildo3/DQC5fJjY+wQqfBM5Ppa1zpSIqCVlLFw
	bouGpk1PTsZUEAIqlHwXnG2MlcWLhUPzjyudZF+bMbolDf3T2uN7fcX9bUTvK1TN
	Ce0bYWpshWHP+nBq5kYNlJm8RIKujyZNyW+i/Rp5wAQbYnaup0JTv/3XJNiiqwKf
	RK+f0SsQ5JwdPdoIlWaeyvYVcZ5pb3wTKvDwGFN/BIyUgF2Ipt3Hdtg0b+Qhfyic
	Lce6hneHtt+YheR/hjI1zbTrn+/bFzGPjc8thMRzNxOZf1eCm703r2904JRbfxVl
	Lw1vQ==
X-ME-Sender: <xms:a-9aahaw-ofwL8joj24tZnLvoVy1q_vUq6V41gf-hThlLxZJtyTPAg>
    <xme:a-9aahstJmxl5kMbqosYMa28OFHTiD1zslDL5IRv5NH_oExey7VlrcztRei8gOF17
    CCzm15-6qB4-FO4Ok1BJ0jUBk8O7k5Lf4AluqWT2ba6MOx-teBx5iI>
X-ME-Received: <xmr:a-9aarNFIb5o3C6blz1cfxwCFUorB_f46Wys2BGxXRtO1Vk7lnny-cVaYWes2y0SB5S-JPAygVmThiXuurY>
X-ME-Proxy-Cause: dmFkZTGGTTbRjNfuyXXY8KUIMiXjqovuz4CSj+LGNj3GLNMZc2bZPFngC0QVgbb6YxmVgd
    uyAb33TlOo/IOXNfH14Cim8fmEJrSqvc2Wq2VnzHOBQgkW0lQcfmJxLdxIFilfXAzJ/deN
    c+l0qxxOUMCX7fcx4cEJrFF8CovPGPWouH1k7N2/iS8bGB00BByuzOPY7+gHVPXrd52QSI
    pnOK34Er16RoF5+Bli1hKQsWzsLkHLQj5yoaVEYSc08eSPUtndErx8/wXs64HgW3ycW9T7
    0cQKyl1o+8LCd2AXkpQsgf7zH5IVcIric4xCyvbz3ZB3aSvmWRI/TLnAJa9mdz1EsyhTNG
    jt3l3PrG3VIwjtoruYFib/ktde/M0OSCjn+SS8ao8Tj1ovc2u0VfJYiGTUSHPfZcezWjz9
    /eaYuCHgvX6s5r/9U0sh9nRCWur/AzkAwFFJeI5PA4I6mcDB9aXGKYB6TqtebW6xX9mBvn
    DjCA27gSxD9vFnimA4oQIQajS2RywYRkIIjWi7afViebD8leBwxt52aayyPa0pdUDYiKti
    OHjt7gjQMTiMqRfZOwKsc0vWp9aYsEdNq1fQDcsWsMKz71IinpmNNNWqxWBMyiMQxwyPQr
    7SVm0W0qgAtT2YauSMvt6N49Ek5Ycdt7PBgAv8em1PDnYz6ibI/66QeJsW3g
X-ME-Proxy: <xmx:a-9aag6e_eL5DkQgbBY0OliUm_xzoGPAGboCqByuOMoZsVuXbAhvyQ>
    <xmx:a-9aapRW7WgnRPOTENVusHx0vRNFvJxvFwPjicmSo_guFd3gzlvTQA>
    <xmx:a-9aalDZFBB7LbpyG2_OmOWBhcR2KlpIPYD07MFvvQ658sIR-6OdUw>
    <xmx:a-9aahFDIjWSYh-KR4wQnXf9RGClLwHvoNrvH74AWs_U2D4SJRre8A>
    <xmx:a-9aavw303-Vs7KjFSNMqkDHovvhvQjzyrTSXa7eECKxlpjOQjn-5mjd>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 23:13:44 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: chaoyi.chen@rock-chips.com
Cc: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [RFC PATCH 4/9] iommu/rockchip: skip orphaned-fault banks in rk_iommu_is_stall_active
Date: Sat, 18 Jul 2026 15:13:41 +1200
Message-ID: <20260718031341.3369185-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b7d71a44-eb65-4b09-a378-225249276f65@rock-chips.com>
References: <b7d71a44-eb65-4b09-a378-225249276f65@rock-chips.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chaoyi, thanks for looking.

You're right -- this was treating the symptom. I traced it:

The bank carries PAGE_FAULT_ACTIVE from boot firmware, and rk_iommu_enable()
runs rk_iommu_enable_stall() *before* rk_iommu_force_reset().  So the stale
fault is still set when enable_stall() polls for STALL_ACTIVE, and that bank
never stalls -- that's the timeout the two "skip" patches worked around.
(On the RK3576 NPU force_reset() was itself returning -EFAULT, "MMU_DTE_ADDR
is not functioning", until the MMU clocks were fixed, so the fault never got
cleared that way either.)

For v2 I dropped both skip patches and instead acknowledge the stale fault
with CMD_PAGE_FAULT_DONE before enabling stall, so every bank starts from a
clean state and the normal stall sequence applies to all of them -- which is
what you were getting at, deal with the fault rather than route around it.
Confirmed on a ROCK 4D: no more raw-reset error, no stall timeout, the NPU
brings up and runs to completion.

v2:
https://lore.kernel.org/all/20260718031146.3368811-1-gahing@gahingwoo.com/

Thanks,
Jiaxing
