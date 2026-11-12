Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520027;
	b=JjX3odSQYgerrXwnoiQZDAjBnUt51jZk9//QhIHzGRklafen9UNhafd3CivaLIzBLp23
	 kDAlpi1gW1tp5n37IDHB5PtlOgF7zgF+tPQdNCz6c/qDdj2QQUHCNMF25/b9aZ82lz1Jt
	 yNlrLP0mpgzlznL34GSGL66ySU7KrH4LyEWXgSOCJO4Y6jnQlzzgaY0DSKZlBZsv4e37P
	 D9OvroqVxcpWIEUmVmGi8wM5huePBkwQDqL7d9iQ8USjGtRhHE2jEC5h6yiB2rRCl0okY
	 //FA4vakjKt2LDpzCj6ftJGwHnKCXecJDacdS4i5qdF0Qx7DzkjaWoz3zDAoUyX6rTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
	b=O28kxxw0A4CiqxMjNsSxYtgrbcSkCeMIlNKQ3LQArDC3Qta5hHAcUQ6p5HLR9V/hZPTx
	 +DCutzh4001curDjWH44BwBLYZsbn+LjnuRsyRxkAlGXSTRCctvsjGJyOWcKNqpRZE5OD
	 q6VZ+uk06iz7RS/rkhicB2oYByPgQ1ZaimXH44L1mQJH+geWgpYaWNy/7EX1Zi2GRaJn4
	 eIl4+6Dfbbf2mWv4pyIbcMrckmBXL7Fgx/40WbBA1w4LXrIhkTmrJejn6V0Oh0z9EVSm6
	 TJHLR0aeMAfbb+NpLMhTbz9BDpwUbeHfbfDH101h6tVfjM8iVAoIWZewa41iwEf+nRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WJhOkpsN;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1F606A32A
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 21:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C1F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WJhOkpsN
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso118762a12.2
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 13:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794520026; x=1795124826; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
        b=WJhOkpsNHKu0uTPzuoO6zfIKSogPNFPtGPkggjZ3SiyJuoTjB+rWzzUkrNV3fPC866
         cNdn4wyuXqDJy+1RcUFa35pECgBVvz3VOrZw3p5Ow/UuwYe82OAQhOil8DzggT+Oq1AL
         lfDtn1Q0WAH5zQovNlUKHnmugz9DcjnHqCtA+kIFffYao4VNjk6rHd8TXNsysxLlfgkN
         GGD/5hFAx7AH5cd1X1uTfJrlUGew8DPds69lRNDBAZwSnJNY3NXs1i3B5vOdD26xAwdU
         M62RmyNu4o2g6AkZ53RfIPBoWXihnKN+4dPPurwoNLfpEP3lT2r/DQyP8OdJDL8vmNbN
         HCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794520026; x=1795124826;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
        b=MVA5MaOozOvWb1yaHW/0EyNqrdEkqZ4L9hgJgOGQAhGTumVsXCUSSEOSPsaO68IMeH
         CGU2/jLbI+xpxtnc0+RFRSXVopQG0kHvxgQInFZ6C3vWNxw78Ks0TwQenBHevLhtO1xD
         ZdKbKtZauVOK+9p0nvLDOV7rJ0+ZFvlATBJRZ9amZ31DT4VUW1xLqyiTcViYSNd/puRI
         BIfOlY28nYCtdlfFvG/ZxCA8sL0Yifz9RcnVPqKs+8iHRKOt7GqqDnRl8E2hZi78Fg0X
         rH08vTczh5heSQXQMuJEAeSz2Ap0P3lOqzP17IKv0rrMMzUDacFieFnuCGO9SjSCwcZe
         K+Zw==
X-Forwarded-Encrypted: i=1; AL+hErHeDpjPrmbBdhIGsxYhKYKHTfI3l63iP4FL3/beRoJoI3T3elZuFV/37fG6Jd33sb6FLlC6jQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9O1hs6zULJW5Z9Fy4RSith6PHTqj2nc8F+3TCkZH3N9XIKNz4F
	5rlu4wDjcjoCCPYKrW6MG588Om4zRCk7xgdltRExuDROYUAaCX/0WusMlVkiAFjydQ==
X-Gm-Gg: AYBFou03BerxpTTDOcmH9VSPXAKhf/DY8e3TjHlkGCG2WQiH3NLV687fd7Ajj3u7hMl
	oRMPT23JJRlLTZ/Nn2P1LSDLHVa28yKZrbDNrVkHLE8K2Oyau/oZVQa/sg63A9/LwHPMzTCBx7H
	JrCzB5cvlbFxPEMd/EUS2cMfLT/yzBIj+GWI1+T4EhjUoxrLoD42FiydCNXBNkbGl3uM4irAhLB
	F0oZHbFhuNOA2RXmqBBP4yxX6172aEGGE3cG3VI5EaRP9B/kc/VBms9+aIzUhECsSQuV+/IevKe
	BNi0cfBSSycloTVH2/NhSfbgIMMYgKxfKbkdboO++uxVLo8R+k6aKHHRTTMGA6lESTB1rkfw58J
	OR49p/j3XmMjA4/Is890Srw8dvGW2Zh365tZodX/AeKsIlUFCUHUHup6pyg60J76cZ3PMWx71nf
	AHHwboTIeLaDKXvbOaRFL0aj6+oNX4TmgSH8XiZ2kmExjB35srwnbiQyOeSp4tZBavGN0qu6YFb
	gvjPjdrNj6bqxpFWoX0HSQXAtGIpfFmoKyrHUOffhRv0G0RWgqDoOx2noYP+T2BPtxyoBwnrcAj
	3egGo66B7HmqiZzQDnZtEQggp+m+QzxIwmVRsalzSNWOKh2AAwNXR121Me3v5WbIMX801ANgbU6
	/aPksy0cYOg==
X-Received: by 2002:a17:90b:30e:b0:3b0:97b8:d6bc with SMTP id 98e67ed59e1d1-3b1b0a0e889mr278699a91.16.1794520025137;
        Thu, 12 Nov 2026 13:47:05 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d257a0sm6493095a91.11.2026.11.12.13.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 13:47:04 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 13:47:03 -0800
Message-Id: <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
Cc: <dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>,
 <kvm@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Josh Hilke" <jrhilke@google.com>, "Kevin
 Tian" <kevin.tian@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, "Matt Evans" <mattev@meta.com>, "Matt
 Evans" <matt@ozlabs.org>, "Mina Almasry" <almasrymina@google.com>,
 "Samiullah Khawaja" <skhawaja@google.com>, "Shuah Khan" <shuah@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, "Vipin Sharma"
 <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
From: "David Matlack" <dmatlack@google.com>
To: "Alex Mastro" <amastro@fb.com>, "David Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
In-Reply-To: <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>

On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
> Hey David,
>
> On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
> =20
>>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>>     uAPI behavior? VFIO_DEVICE_RESET (and runtime PM transitions) on the
>>     target device also bracket the reset with
>>     vfio_pci_dma_buf_move(vdev, true) and vfio_pci_dma_buf_move(vdev,
>>     false), tearing down any active IOMMU_IOAS_MAP_FILE mapping of that
>>     device's BAR even though PCI_COMMAND_MEMORY remains enabled when
>>     VFIO_DEVICE_RESET returns.
>
> There was some discussion about this in the thread below. My understandin=
g of
> Jason's point is that the current behavior, and differences between what
> revoking and move-capable importers see in regards to vfio-exported dma-b=
uf is
> somewhat incidental and not necessarily desirable.

Thanks, I will read through that thread. It seemed like a surprising
uAPI.

>
> https://lore.kernel.org/all/arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com/
>
>>   - Physical target devices and P2P topology checks: mem_bar_descs[]
>>     currently only matches QEMU's pci-testdev, and
>>     vfio_pci_has_p2p_path() does not yet check PCI topology or ACS to
>>     verify that P2P traffic can flow between two physical endpoints.
>>=20
>>     Suggestions on physical target BARs to add to mem_bar_descs[] and on
>>     checking P2P reachability from userspace are welcome.
>
> FWIW, you can also exercise the "P2P" path with just a single device if y=
ou
> IOMMU map a device's BAR into it's own IOAS, and have the device DMA itse=
lf. For
> eventually validating aspects of Live Update, maybe you don't necessarily=
 care
> if an actual peer device is being DMA'd?

The way I designed the P2P selftest support requires 2 things:

 (A) initiator: A device that has a VFIO selftests driver.
 (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar(=
)).

So far I haven't found a single device that can do both. But you are
right that theoretically a single device could satisfy both
requirements.

I can relax vfio_pci_has_p2p_path() to allow initiator =3D=3D target.
