Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC228C864
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567089; cv=none; b=Bd6nZuLSIq4NcY8xHAEzmAJkFPUwJZ2O1gDsSNd6OfBmeu4zQGZW6aHuDphKJTbxCPzSIVXTHBeOJD/9j2x4C0l1Vm6l2jIfjKEkutGhBdewwmybRoCXn43oOve2BXOCJiyJaQyNFp/OFOmV+nVdRExACv8lnd2DqgXgAku3IyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567089; c=relaxed/simple;
	bh=+X0o+fnuucdD9d8XXCCVc6uwc1Q8kkaHvENY2W/iYEI=;
	h=References:Cc:From:Mime-Version:Content-Type:To:Subject:Date:
	 Message-Id:In-Reply-To; b=KTk7QB58/NtL4E/1Oehxyd/G8M4lbHWaX3W4xhhBeHVhoXOnnOQGu186XIzXE8hYNRtC3T7uLoPYhMobZPFjB0LXLobvEbao5mc1Meg96f8nlz4WDLcRn6lpWJWhMucBM4x7/U45s/n8k7uSTxNLVv/qXWQqDLYF5KvBs2oasoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=eOqR0ci8; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="eOqR0ci8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769567072; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+X0o+fnuucdD9d8XXCCVc6uwc1Q8kkaHvENY2W/iYEI=;
 b=eOqR0ci8HLha1Upr0ZosO1BXccbx8FAFF9/7rUIu6Uh/gKy2MnFd9f3zOnGRIpKZijGKFB
 HSoWzS2Hvt52tQ9MqKVuiXmbLGKCNRxEqTgCkbfEGPpkpnPDjzx+RxjIT+etXL9JroG6x1
 ZOROYarsBeoYqIB3Ooju2+y8YNtpG73VKcAkZRs0dCAfGwieISPrSM5e7f14oEKaYrbzlJ
 NQ0JdghJZ7Vo3UbrtECF3Sd5ym8y87WnUyArVtSWbg6q1vcDCiUi0XlvgTc6oFpp5ov5Gg
 6FEBpeKJDrXEFKBwDnChI+772bPBywzYPwELJW6ahYh6du61sZdGZJlNkDmVHg==
X-Lms-Return-Path: <lba+26979735e+93d8e1+lists.linux.dev+lv.zheng@spacemit.com>
X-Mailer: git-send-email 2.43.0
References: <cover.1769562575.git.lv.zheng@spacemit.com>
Cc: "Jingyu Li" <joey.li@spacemit.com>, "Lv Zheng" <lv.zheng@spacemit.com>, 
	"Zhijian Chen" <zhijian@spacemit.com>, <iommu@lists.linux.dev>
From: "Lv Zheng" <lv.zheng@spacemit.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: Lv Zheng <lv.zheng@spacemit.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
To: "Robin Murphy" <robin.murphy@arm.com>, 
	"Tomasz Jeznach" <tjeznach@rivosinc.com>
Subject: [PATCH 1/6] iommu/riscv: Enable IOMMU DMA mapping support
Date: Wed, 28 Jan 2026 10:24:25 +0800
Message-Id: <dcd3f819561abee96f6f60623585deef97f591e4.1769562575.git.lv.zheng@spacemit.com>
In-Reply-To: <cover.1769562575.git.lv.zheng@spacemit.com>
Received: from SurfaceBook2-B.localdomain ([122.224.183.70]) by smtp.feishu.cn with ESMTPS; Wed, 28 Jan 2026 10:24:29 +0800

RnJvbTogSmluZ3l1IExpIDxqb2V5LmxpQHNwYWNlbWl0LmNvbT4NCg0KVGhpcyBwYXRjaCBlbmFi
bGVzIElPTU1VIERNQSBtYXBwaW5nIHN1cHBvcnQgZm9yIFJJU0MtViwgc28gdGhhdCBETUFDcw0K
Y2FuIGJlIHRlc3RlZCB3aXRoIHRyYW5zbGF0aW9uIGVuYWJsZWQuDQoNCktub3duIElzc3VlOg0K
MS4gV2hlbiBDT05GSUdfSU9NTVVfRE1BIGlzIGVuYWJsZWQsIGN1cnJlbnQgTGludXggUklTQy1W
IElPTU1VIGlzIGxhY2sNCiAgIG9mIFBDSWUgc3VwcG9ydCwgY2F1c2luZyByaXNjdl9pb21tdV9m
YXVsdDo1MjIgaW4gZGVhbGluZyB3aXRoIE5WTWUNCiAgIFBDSWUgZGV2aWNlcy4NCg0KU2lnbmVk
LW9mZi1ieTogSmluZ3l1IExpIDxqb2V5LmxpQHNwYWNlbWl0LmNvbT4NClNpZ25lZC1vZmYtYnk6
IEx2IFpoZW5nIDxsdi56aGVuZ0BzcGFjZW1pdC5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L0tj
b25maWcgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L0tjb25maWcgYi9kcml2ZXJzL2lvbW11
L0tjb25maWcNCmluZGV4IGY4NjI2MmIxMTQxNi4uMzRkOGE3OTIzMzlmIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9pb21tdS9LY29uZmlnDQorKysgYi9kcml2ZXJzL2lvbW11L0tjb25maWcNCkBAIC0x
NTEsNyArMTUxLDcgQEAgY29uZmlnIE9GX0lPTU1VDQogDQogIyBJT01NVS1hZ25vc3RpYyBETUEt
bWFwcGluZyBsYXllcg0KIGNvbmZpZyBJT01NVV9ETUENCi0JZGVmX2Jvb2wgQVJNNjQgfHwgWDg2
IHx8IFMzOTANCisJZGVmX2Jvb2wgQVJNNjQgfHwgWDg2IHx8IFMzOTAgfHwgUklTQ1YNCiAJc2Vs
ZWN0IERNQV9PUFNfSEVMUEVSUw0KIAlzZWxlY3QgSU9NTVVfQVBJDQogCXNlbGVjdCBJT01NVV9J
T1ZBDQotLSANCjIuNDMuMA0KClRoaXMgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnQgYXJlIGNv
bmZpZGVudGlhbCBhbmQgbWF5IGJlIHByaXZpbGVnZWQgb3Igb3RoZXJ3aXNlIHByb3RlY3RlZCBm
cm9tIGRpc2Nsb3N1cmUuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBvZiB0
aGlzIG1lc3NhZ2UsIHBsZWFzZSBkZWxldGUgaXQgYW5kIGFueSBhdHRhY2htZW50IGZyb20geW91
ciBzeXN0ZW0gYW5kIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IHJlcGx5IGUtbWFp
bC4gVW5pbnRlbmRlZCByZWNpcGllbnRzIHNob3VsZCBub3QgdXNlLCBjb3B5LCBkaXNjbG9zZSBv
ciB0YWtlIGFueSBhY3Rpb24gYmFzZWQgb24gdGhpcyBtZXNzYWdlIG9yIGFueSBpbmZvcm1hdGlv
biBjb250YWluZWQgaW4gdGhpcyBtZXNzYWdlLiBFbWFpbHMgY2Fubm90IGJlIGd1YXJhbnRlZWQg
dG8gYmUgc2VjdXJlIG9yIGVycm9yIGZyZWUgYXMgdGhleSBjYW4gYmUgaW50ZXJjZXB0ZWQsIGFt
ZW5kZWQsIGxvc3Qgb3IgZGVzdHJveWVkLCBhbmQgeW91IHNob3VsZCB0YWtlIGZ1bGwgcmVzcG9u
c2liaWxpdHkgZm9yIHNlY3VyaXR5IGNoZWNraW5nLiAKIArmnKzpgq7ku7blj4rlhbbku7vkvZXp
mYTku7blhbfmnInkv53lr4bmgKfotKjvvIzlubblj6/og73lj5flhbbku5bkv53miqTmiJbkuI3l
hYHorrjooqvmiqvpnLLnu5nnrKzkuInmlrnjgILlpoLpmIHkuIvor6/mlLbliLDmnKzpgq7ku7bv
vIzmlazor7fnq4vljbPku6Xlm57lpI3nlLXlrZDpgq7ku7bnmoTmlrnlvI/pgJrnn6Xlj5Hku7bk
urrvvIzlubblsIbmnKzpgq7ku7blj4rlhbbku7vkvZXpmYTku7bku47pmIHkuIvns7vnu5/kuK3k
uojku6XliKDpmaTjgILlpoLpmIHkuIvlubbpnZ7mnKzpgq7ku7blhpnmmI7kuYvmlLbku7bkurrv
vIzmlazor7fliIfli7/kvb/nlKjjgIHlpI3liLbjgIHmiqvpnLLmnKzpgq7ku7bmiJblhbbku7vk
vZXlhoXlrrnvvIzkuqbor7fliIfli7/kvp3mnKzpgq7ku7bmiJblhbbku7vkvZXlhoXlrrnogIzp
h4flj5bku7vkvZXooYzliqjjgILnlLXlrZDpgq7ku7bml6Dms5Xkv53or4HmmK/kuIDnp43lronl
hajlkozkuI3kvJrlh7rnjrDku7vkvZXlt67plJnnmoTpgJrkv6HmlrnlvI/vvIzlj6/og73kvJro
oqvmi6bmiKrjgIHkv67mlLnjgIHkuKLlpLHmiJbmjZ/lnY/vvIzmlLbku7bkurrpnIDoh6rooYzo
tJ/otKPlgZrlpb3lronlhajmo4Dmn6XjgII=
