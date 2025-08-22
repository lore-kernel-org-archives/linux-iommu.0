Received: from sg-3-13.ptr.tlmpb.com (sg-3-13.ptr.tlmpb.com [101.45.255.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142D1DB375
	for <iommu@lists.linux.dev>; Fri, 22 Aug 2025 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830201; cv=none; b=o2yINfo/87k0O9x28HElPwdvLN7iW9TQAq/tsVidKCz9VWf2FDKG3EziIcRU74lWAu8MH78QmqItnKmSGbeOr2Rt5+Hps3KToLjuxU5I+ejNINHzIcdpzp8jGZby5vg3zKxW42ZHnFF7kAqFjMQg7QGBKba0PkcWG6z9aeZ4k7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830201; c=relaxed/simple;
	bh=OX0qQeafF4TgTCcyrgXJILtED4m/Hr6OfWXNy/L2kuU=;
	h=Subject:Message-Id:In-Reply-To:Content-Type:From:Date:
	 Mime-Version:Cc:References:To; b=YrCBL+y2Fol4HFxvsDyJxYqQAjO8d08KgGUzp4L90Okfg7TTvdZgAs0eYuDFAIlRiXOydxWgxk1/fzP8H9fqv/Edvg/rnJuVJihzrvpoMarBoDPursZgkTwy43hde8CY/CY6NAf7UG0tQHJ6ObmznohlqNB2RLp+Ircfxl9Cwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=u07qho9v; arc=none smtp.client-ip=101.45.255.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="u07qho9v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755830183;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=wM2Pu7ubOLQjp3YGifNjivB5Nz4a+TlbNw/xHfw3RnM=;
 b=u07qho9vrBAHyq3bmONyU1L7dFC0wt/CFQatDkY2RZj1y+tTdEbjSmlcqa5VhR4HzZt50c
 1XPrvSXvluKmqefRmmu0LioJHxFCN3GZxVNQJbMTUGKvQZyknLxZIvRzX19Fu9jwgujRp7
 MUHD7eRgDzYX4FP5rkiDPecQNrtjLrMKl0ovX2VUXBx/Q6HMlS0V3kGjFj0a5VmrWgGUKJ
 MQkxUGJYep/mkeAHbd7knSn0j+sVzr40TH6k8LFqSzL5LWn9zZSuB14oGjbAVUrFgTZ3Fw
 55c2Il7IudNfkfa1/oVv49H8+7nEUKAK9AFD1qWzIPq7ZGE1vuvjReaa+0dk+w==
Subject: Re: Re: [v4] iommu/riscv: prevent NULL deref in iova_to_phys
Message-Id: <20250822023611.18145-1-huangxianliang@lanxincomputing.com>
In-Reply-To: <aed0e72a-3c98-4027-8676-b8f469d857f5@web.de>
Content-Type: text/plain; charset=UTF-8
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Date: Fri, 22 Aug 2025 10:36:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+268a7d7a5+562c47+lists.linux.dev+huangxianliang@lanxincomputing.com>
Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, 
	<huangxianliang@lanxincomputing.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Fri, 22 Aug 2025 10:36:20 +0800
References: <aed0e72a-3c98-4027-8676-b8f469d857f5@web.de>
To: <markus.elfring@web.de>
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
X-Mailer: git-send-email 2.34.1

> I suggest to take another look for the better distinction of mentioned ke=
y words.
I misunderstood this
    >> =E2=80=A6> Check the pointer before using it to avoid the bug. =E2=
=80=A6
    > Would a summary phrase like =E2=80=9CPrevent null pointer dereference=
 in riscv_iommu_iova_to_phys()=E2=80=9D
    > be also helpful?
https://lore.kernel.org/lkml/effb29be-6d14-47e5-ab71-454119467750@web.de/

>> > Changes
>> > v4:
>> > - Change the summary as Markus recommends
>> >=20
>> > v3:
>> > - Remove redundant pte validation in riscv_iommu_iova_to_phys
>> > - Improve subject line to emphasize prevention
> Does anything hinder you to integrate repeated patch review ideas better
> into your contributions?
Do you suggest merge the repeated patch changlogs?
may a RESEND v3:
- Remove redundant pte validation in riscv_iommu_iova_to_phys
- Improve summary and description to emphasize prevention as Markus recomme=
nds

Regards,
Xianliang
