Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002D223702
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394374; cv=none; b=RdjVi+bQGTHvhClw5YhgL0Yo8H59P7E5d6ytno7Qx7OW6TfEqjIZ3xaOIj/SioxpGjgX1GapFxsA0uhT5ccc8c6nSKA/c8RXx25uOh5QjPrNOvEoiK3PMVxkwFZpl1UPB+jb3//ZMYdSK9JQ/gfYkZIudUD3jbnRRM4/f87aWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394374; c=relaxed/simple;
	bh=RJk2ew42x1OaFHgC10H3ItLiRiqgdw10zjzfWvDhk4w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0zMbuaNRg4bo8tpd0v+wtL9VEk8TlbfgWU5vFt5lWHW6JYQdam7UsIKEeU9BlYL2e4c/4PtDE4P5HoczQ38kCFOEsNa6GwKmrlTMzt/JPYYd4jU0NLsJbZQAHmoQs4UE0aCvpHm9WQaGeDKx+6VdzdW0d1vaBCTEQgQNKPJ9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DcqEiGqw; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DcqEiGqw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1783394367; x=1783653567;
	bh=w1WW+Rf6WB8PFdRwptz/r6ZcYQos2RZ0HVWaAzzGe6E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DcqEiGqwnDffW849Ke0oHoSASXiFHyxSPGSBoDRPf3AoHMJX3sFX6Pias03dc2HK1
	 1JlCZOYHH2vYfe2M59WIyY7bocfkr83QQ10VOqckrDq+sN534l+fh7tr3IZ/HuLNaC
	 r0xCZ8vIEkccxDCvWDYWig3aItBqrpImSWDoxG3spZHpfCbCBtiiAAQO1kb8On4V5o
	 GW86fXwNbPYZ1ocx26EhShmIqqlYQ4Kt+joWExfvdXcrH/8/F6AfqsT3GXUvUFSrpd
	 /zfoEyblg26Vmeuw7oTXFpSb9kGtmWwBf9lWRU1U9RlX0++cJ8E6NxM4f/R5GWmPVb
	 kcifZz5w0+Ycg==
Date: Tue, 07 Jul 2026 03:19:22 +0000
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sm8450: Remove unneeded reserved memory nodes
Message-ID: <c11f9ddd-8533-426c-8a88-0ed461f6a30e@proton.me>
In-Reply-To: <4g6y4q2udludhwmoqc34afwj5svra4a4j5bmpqza7h3av2oov7@6k5r7a4meruk>
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me> <20260622-sm8450-qol-v1-2-37e2ee8df9da@proton.me> <e1e492ab-884e-442b-8410-cc100c54fd5f@oss.qualcomm.com> <6123a923-21dd-4f69-9ac5-02165963027c@oss.qualcomm.com> <b3541802-3035-40ee-8327-a65bd5d2dfee@proton.me> <4g6y4q2udludhwmoqc34afwj5svra4a4j5bmpqza7h3av2oov7@6k5r7a4meruk>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: f44e9ea796ae9a36b6ac3c3fb88470b5693b7329
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/6/26 2:24 PM, Dmitry Baryshkov wrote:
> Please verify that you can actually access those areas (boot with
> memtest=3D1)

Thanks for the suggestion!

I actually did boot an SM8475 based device I'm mainlining (motorola-bronco)
with this parameter.
Deleted regions in DT are as follows:

/delete-node/ &mte_mem;
/delete-node/ &oem_vm_mem; (seems to not exist in SM8475?)
/delete-node/ &qheebsp_reserved_mem;
/delete-node/ &trust_ui_vm_mem;
/delete-node/ &trust_ui_vm_qrtr;
/delete-node/ &trust_ui_vm_swiotlb;
/delete-node/ &trust_ui_vm_vblk0_ring;
/delete-node/ &trusted_apps_ext_mem;
/delete-node/ &trusted_apps_mem;

Here are the results:

[    0.000000] early_memtest: # of tests: 1
[    0.000000]   0x00000000808f4000 - 0x0000000080900000 pattern 0000000000=
000000
[    0.000000]   0x0000000085200000 - 0x0000000085700000 pattern 0000000000=
000000
[    0.000000]   0x0000000087f00000 - 0x0000000088000000 pattern 0000000000=
000000
[    0.000000]   0x000000008b91c000 - 0x000000008ba00000 pattern 0000000000=
000000
[    0.000000]   0x000000009ff80000 - 0x00000000a6e00000 pattern 0000000000=
000000
[    0.000000]   0x00000000a6e40000 - 0x00000000a6f00000 pattern 0000000000=
000000
[    0.000000]   0x00000000a7000000 - 0x00000000a8000000 pattern 0000000000=
000000
[    0.000000]   0x00000000ab350000 - 0x00000000b70cd000 pattern 0000000000=
000000
[    0.000000]   0x00000000b70ebdd1 - 0x00000000b72ce000 pattern 0000000000=
000000
[    0.000000]   0x00000000b7fff000 - 0x00000000b8000000 pattern 0000000000=
000000
[    0.000000]   0x00000000b89e3400 - 0x00000000e0600000 pattern 0000000000=
000000
[    0.000000]   0x00000000e0b00000 - 0x00000000e8800000 pattern 0000000000=
000000
[    0.000000]   0x00000000f1400000 - 0x0000000100000000 pattern 0000000000=
000000
[    0.000000]   0x0000000800000000 - 0x000000083af00000 pattern 0000000000=
000000
[    0.000000]   0x000000083b500000 - 0x000000083d300000 pattern 0000000000=
000000
[    0.000000]   0x0000000840000000 - 0x000000097f089d40 pattern 0000000000=
000000
[    0.000000]   0x000000097f089d6f - 0x000000097f089d70 pattern 0000000000=
000000
[    0.000000]   0x000000097f153ff8 - 0x000000097f154000 pattern 0000000000=
000000

The device didn't crash at boot, and everything works as expected.
For the record, the manufacturer has made changes in downstream device
trees that state TVM is not used, so it's expected that the device works
without QHEE and TVM regions.

Regards,
Esteban

