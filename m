Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF21275B18;
	Tue, 17 Mar 2026 05:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773725360; cv=none; b=DxYpA393ClapLnjVrncrjmo4dVHYoB5YlB7B5b+kY1QfRa9U2xWi/8ZENKHe9min2SqENABk/OxuDpkUMTmNwsmJHSwAubZcmn/Z2lqBxhQtCoIlETsXKA5d41bpQWXqcpmdiV5ulhL7OaKzHkLJ1GJikI04iMlkWNbM7HgfuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773725360; c=relaxed/simple;
	bh=Nf719nA30D8prEus9dGdhnEqiqbPlb11hG6PJJdTEfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWSkBrtI/rS8qWNvCjpbJimSNbSzFKL7q5GkRtcrBF2717yy6Y/IUCutHVtDb/VhxCU3LfcNhzmK5ZlPx4dA5QSfcJPzDMyaySeTDqXRo431ZQ33ll0fhmqpPKDumHHDRuxTeagxjWyKYgMLWJLTXmCk1GPkWtWqAZp1YTuslNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBBRvNcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBBRvNcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1D9C4CEF7;
	Tue, 17 Mar 2026 05:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773725360;
	bh=Nf719nA30D8prEus9dGdhnEqiqbPlb11hG6PJJdTEfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mBBRvNcSSEIrX5WbrxOAyAXPcRP6Myb9HARIBq1YwUn/ZBJzCpXxb/JFclPm2DtvD
	 +frAc7ngcpo6BtUrBehO2jzIOcam88SAvL3OW+8YuBd3Pt75keqCoLZ29dx/sbHJ5P
	 u8NZ9Vb5hatnC5a/MmeRayQHJ0M/8AHDCrDAnZ2MiDmso1BTZGc99qckvJ+Cm2V3WY
	 T3T3iiSPxZ4gQrSImHF2Ah71Nv+bg68o5TgofybaUz8y1sVDBV36TZ1emJkm7pAQLF
	 WzcB/+PEBgoJDFTzXv575s9QqLpbe9+9JmQxt1bwVsJuLDKbRN2bxzZuiyLmwTplt7
	 anN29qS96ghEA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, suzuki.poulose@arm.com,
	steven.price@arm.com
Subject: Re: [PATCH] arm64: swiotlb: =?utf-8?Q?Don=E2=80=99t?= shrink
 default buffer when bounce
 is forced
In-Reply-To: <cd026591-c278-4f89-9d21-1a2125a85a44@samsung.com>
References: <20260120070102.182977-1-aneesh.kumar@kernel.org>
 <aYOVf066Fdr9L-nw@arm.com>
 <CGME20260206061145eucas1p1917446df9763565b2b5ef829c5350a69@eucas1p1.samsung.com>
 <yq5a8qd6iep6.fsf@kernel.org>
 <cd026591-c278-4f89-9d21-1a2125a85a44@samsung.com>
Date: Tue, 17 Mar 2026 10:59:13 +0530
Message-ID: <yq5av7ev6n2u.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 06.02.2026 07:11, Aneesh Kumar K.V wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>>> On Tue, Jan 20, 2026 at 12:31:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>> arm64 reduces the default swiotlb size (for unaligned kmalloc()
>>>> bouncing) when it detects that no swiotlb bouncing is needed.
>>>>
>>>> If swiotlb bouncing is explicitly forced via the command line
>>>> (swiotlb=force), this heuristic must not apply. Add a swiotlb helper to
>>>> query the forced-bounce state and use it to skip the resize when
>>>> bouncing is forced.
>>> I think the logic you proposed in reply to Robin might work better but
>>> have you actually hit a problem that triggered this patch? Do people
>>> passing swiotlb=force expect a specific size for the buffer?
>>>
>> This issue was observed while implementing swiotlb for a trusted device.
>> I was testing the protected swiotlb space using the swiotlb=force
>> option, which causes the device to use swiotlb even in protected mode.
>> As per Robin, an end user using the swiotlb=force option will also
>> specify a custom swiotlb size
>
> Does the above mean that it works fine when user provides both 
> swiotlb=force and custom swiotlb size, so no changes in the code are 
> actually needed?
>

swiotlb_adjust_size() checks whether the default_nslabs value has
changed and avoids updating the SWIOTLB size based on different
subsystem logic.

void __init swiotlb_adjust_size(unsigned long size)
{
	/*
	 * If swiotlb parameter has not been specified, give a chance to
	 * architectures such as those supporting memory encryption to
	 * adjust/expand SWIOTLB size for their use.
	 */
	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
		return;


To handle swiotlb_force alone we can do

modified   kernel/dma/swiotlb.c
@@ -209,6 +209,8 @@ unsigned long swiotlb_size_or_default(void)
 
 void __init swiotlb_adjust_size(unsigned long size)
 {
+	unsigned long nslabs;
+
 	/*
 	 * If swiotlb parameter has not been specified, give a chance to
 	 * architectures such as those supporting memory encryption to
@@ -218,7 +220,13 @@ void __init swiotlb_adjust_size(unsigned long size)
 		return;
 
 	size = ALIGN(size, IO_TLB_SIZE);
-	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	/*
+	 * Don't allow to reduce size if we are forcing swiotlb bounce.
+	 */
+	if (swiotlb_force_bounce && nslabs < default_nslabs)
+		return;
+	default_nslabs = nslabs;
 	if (round_up_default_nslabs())
 		size = default_nslabs << IO_TLB_SHIFT;
 	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);

