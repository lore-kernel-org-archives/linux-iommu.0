Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370F36493A
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788629216; cv=none; b=EtHTfmbRK0+PcrLeNJ76WHfmIdYgP9IqYLHunxpTwedMjXAwNGdsApkpZNbh+fYufBcCnlUREHt6J06MQ7S4vai951fRQMoFPWAbKyVvQv6y/uToleaY5TlXmIMgvfyk9AzpZeXnGYc+2slR7/giZtaY4CWU0kR3RgjZINRFDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788629216; c=relaxed/simple;
	bh=gm2GAbU2aapkEro2/HB11RPcZtUVao5xZnpvqLMHfzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAIh2MgnkUdqwbE/w2SBDqkPiEXfyA/ZY1V4iWheYqJ4IDZ1glwUqFRcT+a/ZtKTXrqWQCcTsNxBKQVQymlvKb2sSzOZprSvlsoIXowy3MGLE6dMonQCg0ViVszSTneRyLGpgwwL8ePc9poCLeiTx6PftQC9W/NrfEoUoRztTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2YGkKzQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2YGkKzQ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-853c07a76adso1996360b3a.0
        for <iommu@lists.linux.dev>; Sat, 05 Sep 2026 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788629215; x=1789234015; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gm2GAbU2aapkEro2/HB11RPcZtUVao5xZnpvqLMHfzg=;
        b=Z2YGkKzQvIE/SgAsZLDFsXQV15PLOdCxZ5SZMrG+ZiFOASGbguihVuUnWY2hRVMjOO
         VAbg2R++GtXxqIsL4ZwvMDIbRgj34iNG3vLyRPZzNQ5IEyvlMAROq9qGVAHNG1K84SgX
         EW001Q55O8p0AhnqQlRXc95f6QViKHTyLUEPFRM55V+0rDPxNb+ZLPzlBDAIC4t028Ot
         XryM2RK8NH1Yyoaq7D+pWJWw5pyb6mLIWNwLN1c8XTCVFDV66GgXJC+FgNgfxkLMboKL
         QEsOKvmpkkH94pdHgrajB8Z0xSPVVhFI+Y7Wii2hTFiYxSVgLc9O83ZL9PH5SMxpfSSK
         pV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788629215; x=1789234015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gm2GAbU2aapkEro2/HB11RPcZtUVao5xZnpvqLMHfzg=;
        b=P5XlboYl6r48+26tq4jWnra24SIAHOU91DS4tEEv4IKOXwYbCwH9WsqU3aWWv2xh6N
         D3lgGYkrJnVDJNbojxcZYVdxrGB+xE42u3NiU6SD05drUwe+/XC7SYic54Sv5GqTrBP9
         jwhGEwub7UxBH8BbTnV5uZWlOiDho/cfKrjOQUfAAVT/ZIGvqismLxT9VUzjSf7I9fFu
         Ep0uWDFgI+RuCr68bshw5eT3f7cBcmWRwf/jhz+OYFmliFqXkbi/duSTBZDrGPfIj+LD
         aoeoFL3JNHbP+eMr8LOEryshVCucusYvVLFDlKLTF6tVet8tHlT978HCOjPzAKRfeZvr
         o97w==
X-Forwarded-Encrypted: i=1; AKwUvBzNmCfohsOQyQ2PD9jaP6UDwTh7RYvvLAhm/Ug5BzBde3RCfoMlneP6Uy2bcHk0TDLVMVq+pw==@lists.linux.dev
X-Gm-Message-State: AFuF++mDF7lslCdLpAiVMuJAn9kHr6jMCsmEOV24M8MHrie/N9NiVpmf
	jUQAR8Cqodgt9tuRcoMkU6ATiKMI3u+2wkLszvUZ+ztNfzLzRyww/q4=
X-Gm-Gg: AYBFou1z1982KvQqAc2MQUJlSN14Ui7sVDao7pkd9j00UGrUeS9E6aen4sxn+q7EhL+
	idWAZoEi6eSFDaPD3Mc22/1TOgyIY8clCOeLxinKkk4lsqothpFAvRsi45F+UG5oA2ZegDfa3en
	3ujjNPOQ2DIndTfTduribDQ1oFSALKgzPz1lejRTk3gEO7qXmQuIlrUZqAznZ1x4pjEFkswDUTK
	heIAdV0FqJ25b+6UikfTwxoDQo/WRPEhbPoQis+RlJgpvs0uiaBc6wS5VxKyUtXRcktv1mpQ7CE
	BUxpFpSTG7tAqLWwbwMoWZM7sekQuOnHIPRZGfrDpNXOx2T3+y5K3YXtSYlH/HyvjqP1l2Ihfae
	bwUXnCxbczzZlF2ZgK0ftMTDNA8ZsUo1a4jsm8IBqaneUYSZ7G0udJmjXqNBuOdAagdB+EQi9ka
	SZ97HimIkgPrPxOZOBMq9fd9mWLw9cgsKQKFxOT11IZjew4edYjvVfsb2Hvv4lKZ1kwFXdsMTkc
	ySwUArypuno6j8=
X-Received: by 2002:a05:6a00:328f:b0:848:77b3:579a with SMTP id d2e1a72fcca58-86168b8a898mr19041449b3a.17.1788629214993;
        Sat, 05 Sep 2026 10:26:54 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc465376831sm1061373a12.9.2026.09.05.10.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 10:26:54 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH] dma-mapping: don't trace the DMA address when the allocation fails
Date: Sun,  6 Sep 2026 02:26:50 +0900
Message-ID: <20260905172650.158565-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <568a4f04-e0db-342a-13a8-886cf6b2a8ab@linux.dev>
References: <20260905071919.30784-1-donggeunyoo.kernel@gmail.com> <568a4f04-e0db-342a-13a8-886cf6b2a8ab@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/5/26 08:57, Sean Anderson wrote:
> I don't understand what you mean. We are literally in an if-statement
> that checks whether the allocation succeeded.

That if checks whether the device has a coherent pool, not whether the
allocation out of it worked. dma_alloc_from_dev_coherent():

 * Returns 0 if dma_alloc_coherent should continue with allocating from
 * generic memory areas, or !0 if dma_alloc_coherent should return @ret.

It returns 1 as soon as it finds a pool; __dma_alloc_from_coherent()
stores NULL in @ret and leaves *dma_handle alone when the request is
larger than the pool or the pool is full. The third paragraph of the
commit message says this.

The second hunk is under no condition at all: dma_direct_alloc(),
iommu_dma_alloc() and ops->alloc() return NULL on failure, and the trace
below the if/else chain runs either way.
