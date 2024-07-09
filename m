Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB7B1B3F36
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542957; cv=none; b=oT3y743gwct0nzTSiC5cWhEg2QPcg3pM3j1bSs3qFgNnGhCKB5iPeKtdA8F1nqgSkV5bRrGHrMl+71SAfk4+YDN3QzZlM9dbCArNQE5NnAspuqe2xHKNGKQcLxKES+3BeqifXK2+k9fQjwtZKuA4FW6M+4Q04CWgPsgJRwSx6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542957; c=relaxed/simple;
	bh=IM6QmybZepBTV4M87U3hzs2YeN+T6D14TFCsMzcbKQI=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=KBoSObtkiz3+gd8gsLyxx+TFMtfNMlXHORYJS00vCEvk6EQXUtTJtQAjnPze8SWHpZXrV82afYfBXW6QoE7T4BOOmSdiI4tGzkzIMU65IRtT1smPHPVwObyTh370F8pCzuHDbNr/zhoGAx8UCWRfe+cbAl+3gQuMLPgKULJCWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=J2vy3F2h; arc=none smtp.client-ip=203.205.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="J2vy3F2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1720542951; bh=IM6QmybZepBTV4M87U3hzs2YeN+T6D14TFCsMzcbKQI=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=J2vy3F2hwzLC0TmCIy27ypDQgl0wf7fj2aryLyfVQoEzrKsJCvsuKVWhVABhX1GAe
	 tuKISqs3dZtCsbDFSxEP8kR5JRRwzSAVzMf2Xh24Z+7MT9OCoydhEjUFbMq7HqTxjz
	 eSmIJFR6Vo70NpKVWHFKuDZnjzy42VJqoQ6ZJ3gc=
Received: from smtpclient.apple ([2408:8207:18a1:c8b0:118:fc2:1adb:e03d])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 76DA60CC; Wed, 10 Jul 2024 00:29:45 +0800
X-QQ-mid: xmsmtpt1720542585t6qpb6cno
Message-ID: <tencent_9CE4ABB18A4F4490459BC3111B5726262905@qq.com>
X-QQ-XMAILINFO: NBOcPERDMH3AZhswaHj/Ct8I/ngCFLeZb6M2dR61l4SAnoiBcwyIru8lnhyAtu
	 MpuJkMSfRgUD70tI33RtgrHtUZrdqrDnkJL20+m/c9+nphmn5YrYZFsnMbP1DJs193Zm6gjmXgRX
	 4HDpVZXuchh8+oCcQhR2y6b4tOhMsi+qItAk+anUGptxsKmyRjRDD2M1Obospr3ZueRyZK+3RRHi
	 SzKwaABCrUrNQEQBmCkDqvaf3FLEXDmQUTuUGHabtMvaY5KaH1s9mMowhjp524R9CEC0FKTGrpoZ
	 kyCDNsLRxR+IbsqCoouPB+MavRXwXMaeqWP7HAQy06lqtM22b4UJY60eS2Sk62+LE4DL8Y5GJjNG
	 5gAi+5BjiOh79UrV0dyJCWdtz5zgumPV/5GEvVVHIy5mrHCzey5+1CnGMTiHM8cc1E0PFn9+4Lep
	 CF75gi8OiTWav/PMf6KrE4NxYTiPFyfoVKdzaKYBExgZ4gP+FjPTY1zQDfa6csa0vvyo9/sSd9je
	 YNPcBQxTJsbRuan7+e/Gv+ZTGB611L1iJJeZxrslo0yKUCqwRoaofWWGp+x1+jtPtVgmcJzymm80
	 htS+vIZAZVyl8APJpsmxuX83B2cdHpmFy5DRJH6kIZL2+jCGQnAalJqx56y+dniDTpC3VylSw4A/
	 Cr3M9MOo5poR8HCsvsuycoLP/nJ597ZzfsJLhc/Kt7ohBqxE/DuWnuoXKjk2Udr+XcIw7mdjQlP3
	 HWJ31cR6ebyINxqNcSRyom6vaO/dQjKynOOouZEDhmnK0+D4m3CjAm3JbjWWMBYnEqI0Iipb6NkL
	 5SJfelX78FoBCgMDU2J17pkuPy/W/T4CEyiAZEu6jbmA6p2jLKNwR8nNLJRpW55ylGh+bUGCMhQS
	 +eofu/xRbOWvPzlU5QzOXR8d4exCu6jfMUI0CNxfeppvGzRty9fsg9rMZFu182lA06hXnHMAOzE+
	 dsbuY7SVrr7lsPaOg0nuOwGCEZildveVG9ryVKeEvqjShbhx8YEIpULbPr3wrP9WsxiENbCOE=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH -fixes] dma-mapping: add default implementation to
 arch_dma_{set|clear}_uncached
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <42552be3-df90-4f8f-a27b-abd08e350fc4@arm.com>
Date: Wed, 10 Jul 2024 00:29:33 +0800
Cc: Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <7FB35339-3F19-472A-8E66-31C608410600@cyyself.name>
References: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
 <20240709111901.GC4421@lst.de>
 <tencent_651BC4D11C9730062064ACB186AF4A904005@qq.com>
 <20240709114629.GB6959@lst.de>
 <tencent_30E109FE684F391AE15AC6F4854034C2F00A@qq.com>
 <42552be3-df90-4f8f-a27b-abd08e350fc4@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jul 9, 2024, at 23:52, Robin Murphy <robin.murphy@arm.com> wrote:
> On 09/07/2024 1:22 pm, Yangyu Chen wrote:
>> The only failed symbol on the kernel with `ARCH=3Driscv defconfig`
>> is `arch_dma_set_uncached` since the compiler requires all possible
>> values to be known. I think a pattern like in kernel/dma/direct.c:349
>> for symbol `arch_dma_clear_uncached`, which uses `if
>> (IS_ENABLE(CONFIG_ARCH_HAS_xxx)) xxx` is acceptable. But for the
>> symbol `arch_dma_set_uncached`, a complex analysis is needed for a
>> value set in a block of branches. I think we should not rely on such
>> compiler optimization in such a complex pattern.
> I'm not a compiler guy, but is it really that complex when the =
variable is only ever written with the same compile-time-constant value =
that it's already initialised with? If the optimisation pass is so =
focused on being able to use a conditional store instruction that it =
would rather emit one which has no effect either way than elide it =
entirely, that doesn't strike me as a particularly good optimisation :/

I confirm this is a regression for the compiler. However, I think
both the compiler and the kernel should be fixed, as I mentioned
the complexity of this pattern in the last email. Also, here is the
only failed symbol in the kernel with RISC-V defconfig.

Thanks,
Yangyu Chen

