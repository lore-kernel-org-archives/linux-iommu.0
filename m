Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794314458;
	b=H3cgDXKGa2gejKrcBMXtFPAJFXms1dqpvar4NSDZhDs61/QxpXSwjs7xdaEvmLKFTuiC
	 pZ6flOqSdwrZ6uiUKsdBgjHu204v3K2vt5a/CIWDH/yqZAb8ZdCewsvASpr8TY5a024/3
	 08QJIswsrChaPxgwE5spS9JJ4jVX3Ukr0afRx1LYehOvCprzidbMg9XXW83pXmKLxqUr6
	 h5qdeNVLjokea15qcZzhy7In8CFXjMSkq1Ohv6gSCSuc6FZ09HzNfPZPjS35OgbEP/fli
	 oTKCzVyWfFItXPbiz5Pt0eROoJGHr8njjLYMFinTyPptZZMvW5TebAGJ4huSg6ZzDoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D4gMZ1PVA/qgtmCoqERD1UHw3rhXprh1G5vdxXe7myk=;
	b=ewoVKWqWc6dSXpc+Jdzng2E4rxROPAqMUlQrqG44L8i/ooGyTwnSnjybA+5V9TaCLMai
	 0CR+qe1hqf8T6GquW1b+qRzDzFi1nmrchWik5pBPpflLz8ALn1V+2AArkOP6p//lxui6L
	 I+UWDyFn7QjaFn2ZvYHJzhq9Zk7yNNEGK4XPxadaTA+U0tCdvE6GJqS8z2X1WqB91c54Y
	 8zt470Cow9jB6ZfpBmluV9K0Zv0iMElMvDrvDDYlo+M0gt5gco+moacHpofXqCJ8NVzeA
	 0s6Dx0+ZcK0k/RoKU1IpCL08+WRi3opPlMb1DK7B0azraihtOeZvFaQVKcQZDAaMj+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I37Ixyso;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052F60A2606
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 12:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4052F60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I37Ixyso
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-943e8d35f74so169391585a.0
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:40:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794314457; cv=none;
        d=google.com; s=arc-20260327;
        b=aWpERyp/jW8OGkzoENY3i9DkPrbdOuzdy0YQ3rn56yu5x+FAkGFVCYyquanLIBHu6z
         zl704cWxgOJXxWxtXLdtY1MIR9ea/4RD5HljRwn1MN4hGiFNrCYu8wmhCLsR8+djun/n
         RAHFKBx3B3z0fjnHkSEmhqa2pHOHQvKlhpg/XcrIJbfg/MvPwVcKo60ZNK3/MtiBfATD
         1/TCD4nq6OGwSeJjan4ZzBu9+l/YdfQscbDOZQygqf4JHDHHVhLAxB6J+7w6AHHVvfGY
         KKlSj4m+kOiBELmHZquKs92b4olGBpnQ4xcGrI8qapkUUiqUPGvyjhUlCb6P58oiT5a9
         xyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D4gMZ1PVA/qgtmCoqERD1UHw3rhXprh1G5vdxXe7myk=;
        fh=/iOlyuheF05bPxM/YKAMkVMRyUqQiSkC3xrw9euRnig=;
        b=J3Usuzyd7mdmASa9CIQY9zNo+K2AQmYny47nCLKBUsF1ak5uiDhEzmIrDSJtWlSlg0
         EAE7JkmrZJlsv8ze4MgfAtiV3yQFL9xKd7dM/GbdowZU08zmYJtwsigdal5CAtWqyMgz
         gHEx6kG70Fwm/hIFIInODCgN2F5QX9sUh2oRHNHZn4ZCYU/qg4A2rzyC47tAWMjGp1Aa
         NQ2+iWFrQWFcjkfx5jhAmtYifcDa70S8MF5LYpnJzSzQmN03QiRnsSC99LjWpFE79eAK
         pVz3wofmquSqoVB8QPYm3mrTdAbcTXWtD/KtoqrU+FQ6yfVnUoczdWBMR41JNJmVHapX
         tkfQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794314457; x=1794919257; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D4gMZ1PVA/qgtmCoqERD1UHw3rhXprh1G5vdxXe7myk=;
        b=I37Ixyso/IPWrAdsFGjS/BR4/l+3OXpxnHp3EyU09FAo+r8prxPjbUr5U4hEHcyV//
         XE08m2aiMW2FkZUeL9Yc8KMunkazFGs0xTxQ0WC6lvQiAtNSkYwjSEUi6QJiymLA1MIa
         MO2UFWXUi/6GoGQ3UoD2Ri3PfjOX56Jn3gY6Vg3cSwnTujowUgozR/toSMFKii/q+4DB
         K6eJ3k/odqWeerbkLcKvsH4nY1FDFgZd2sP96R4a9otRZRpY/DOENMQfOHvDn+X3GBUB
         RUv9URsUkP8qG2W3sTAQvyStpQrXuSau5rqKjKrIOm6VUiPdAru96xVAp6oVpnR8Mej7
         HYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314457; x=1794919257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4gMZ1PVA/qgtmCoqERD1UHw3rhXprh1G5vdxXe7myk=;
        b=hRR6hTxg8/GsI1Req6GOsaF4BhbyILzzrARzjPhigTUkDXvM60W/2LYBbUHqQcmcuX
         9evcTrOUHE/iY6ovQaSYS/kQUDXxiEy404lVVphPo2EHgs4x9Bl5yvv7hAxINsW9GmaB
         FZ6cUMGL2tKRlaMI7PHPpl219sAHBZGGOJpzy4cLco8CIETTL7CHRgE/0+haHCcXju9H
         ZfWHHhN2L4YXvj37CVAGJ9N/EAMXcNUhr0vLYgRyFE7vBVThQ9nPXiw7sg0op2DREVAf
         B9AvBYC/4PJJPn90jASJDdgleeQaqiz+CI1TZD6KKbXcOafL/HhouCbNLmon9XASLoQl
         A3HA==
X-Forwarded-Encrypted: i=1; AL+hErFDgx2sDvQijKyggAin00/QTgGv51kWC2xfOkBFNxYX1x1OtA6x0jxHxUfSOcpyISPE+NbGdA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ZZ2GJAihsTHKi231mt/tA+iWod8A+mz3QHicO9aPPeTYQ9ggb
	cp+mbbty7Fl+Xa1Upk7pqpSBGdOprk9AzYQVQHYsluNQBtJZuDxQmcdMSxunMuvarqY8DYTU1Y8
	DZIPYiHEiw+7uKi9Te/WaftScS/Cfdug=
X-Gm-Gg: AYBFou2qdhbwyxhYb+Whl3yFhir8z0vjDHlhNmyetEPuvtll2A4AJdbymxQikUUOJCr
	xIP+7Q7wte6tj7O/6xrenntnoSXeMuQVeKg9C+oVnQfXf0shGslV1VwM/mm4/HGOKMm1//CyPJr
	imivOcOnXmkYuXPhnSlekeQYuDEIIDPL3aVhUJez1cVB6XrwlKq54Kcy6iMxxxBtY6Alpo0xeze
	o987Ly8MJMGhmgOfYad37pDgFtsoXdnnVNGozYrHtstCOzUrRhS62HOD2GKjIGlGvsxY2218crA
	bSu0beGzjvNuejdu32+/h7ahsBlcStMuvMvlUg/Emhf8Jjb32z3QnZ2gn/eZ8oVwBfq9t/V24b7
	SQXmVNxwoNyeOeGMCd0PeokNFv6dOo4n+BpgYgBvlL3MbarcEa4qSLqSL8ICOCx/21SkOTNAT07
	peYG6TJA+e3U9dzh07uKXO
X-Received: by 2002:a05:620a:450d:b0:93c:b6db:8c with SMTP id
 af79cd13be357-9479f093b28mr391627885a.0.1794314457277; Tue, 10 Nov 2026
 04:40:57 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CGME20261110094847eucas1p125691a852f3621482adae13de1205223@eucas1p1.samsung.com>
 <20261110094830.2081847-1-m.szyprowski@samsung.com> <20261110094830.2081847-2-m.szyprowski@samsung.com>
In-Reply-To: <20261110094830.2081847-2-m.szyprowski@samsung.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 10 Nov 2026 04:40:44 -0800
X-Gm-Features: AclHuK83CWJc5YlF2QehrZfUW5W7mZ4EuCDQrpmAsXstQoXrFuDrYSPavdO9f3s
Message-ID: <CAMo8BfL04-yz8VppH6P+dcBTJEvM5zPR-=d9GMdRG4F2B78YXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] xtensa: write back dirty lines in arch_dma_prep_coherent()
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:48=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> arch_dma_prep_coherent() is expected to remove any dirty cache lines
> covering the buffer, so that they are neither lost nor evicted later on
> top of data written through the uncached alias or by the device.
> xtensa implements it with __invalidate_dcache_range(), which uses the
> DHI instruction and discards dirty lines without writing them back.
>
> This loses data written through the cached kernel mapping right before
> the call. dma_direct_alloc() zeroes the buffer with memset() on the
> cached linear mapping and only then calls arch_dma_prep_coherent() and
> switches to the KSEG bypass alias via arch_dma_set_uncached(). On cores
> with a write-back data cache the zeroes still sitting in the cache are
> dropped, and dma_alloc_coherent() returns a buffer with stale content.
>
> Use __flush_invalidate_dcache_range() (DHWBI) instead, which writes the
> dirty lines back before invalidating them. On cores with a write-through
> data cache it maps to __invalidate_dcache_range(), so nothing changes
> there.
>
> Fixes: 0f665b9e2a6d ("xtensa: use the generic uncached segment support")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/xtensa/kernel/pci-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
