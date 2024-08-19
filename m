Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A43EA69
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044667; cv=none; b=Tl5DWXIF4xfOxL8sh31cG93OYuXtvFHnzAW5zg3ZvZcb/vjif2sAUcfAX1nA0a6HzdVcolmAYBsnp18LCYej84u+985SBNEkRcDcsgLfw/ggcA0YZTWLtJFjJSxsbzv3IzqvltL1eydQp7++qyn0OawfTkGYe2TVi0wocGo17t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044667; c=relaxed/simple;
	bh=C1nYJFSadkBqsA2XjIbFq/oop7+NYZUTKMV4DY0FdEA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NNt/vC5Cn7Tl8iDQIfhX4T1jXFLOBpEE2mMst2uug62ywK2koqo9fpxYcBnk4EDogyyNDpkZSJr3ZT6mdPu1L4yAx1rzsGBsYXlEXUA+ZsMlxpLwOYfNlxYOjgFVEtfwCyAIOuSZ9cp7S4gLf3RU99bO5JnYXBZayxVwjBh42Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=fASU2U/y; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="fASU2U/y"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso1904306f8f.0
        for <iommu@lists.linux.dev>; Sun, 18 Aug 2024 22:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1724044664; x=1724649464; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyh8E2w6qS2dDnFyvllL4xJUAKlas+oNhNFEyWDUr/o=;
        b=fASU2U/y/DMlGFXGRcvNHfMTUWujP/oki//Pyl8zDI5FG7BJJPOZusbQWQkMlxgqq5
         X8v1AHBnDX9IEBNgjS21nh0sIcEBbWK8SyJsv9+4WPoM4IX8HCaw7i2EUCFccZIAy7/p
         EJ3DkelyCq/tQWNvjczNurWZj2+1s99b3/59ZaN4nBrgcny0OcUxZC5+3TERK7ct/R6u
         IesQR7bF2bS5S03pjRtftyAYTpzLYjoVvKUiNPZAQ8u1gOmqN8Elr8e4rwk5vmkm20Fb
         2XI28kXTrD45k21WwEit7GDQlhWPPANdyjrigewsPX2kyOxERvrsAmaHX4KFFNVPnJrp
         C6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724044664; x=1724649464;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xyh8E2w6qS2dDnFyvllL4xJUAKlas+oNhNFEyWDUr/o=;
        b=Z6kdMNXGFeeLbjooXL2Mk+gDvReAtFZWIHwPHrT9PNQ6DhjkxrFR3u4NgE8S1ihDUY
         cW/cvqOlpXtbQ+v1+Faaqna1GPhGyJEiePna0BGF21Twb9e0p6oXliaxLF2IlijmcdJd
         MdYOCjKY6+VBfjeatqksWK6TQtjQame5DAusU05hh7otX1XVqMbd59MRcADLyEweYBZX
         An2toH+QIzz1maq3LhWNrwlk8Cco+RubhWS3M5bdZYKUr4D95Ahn6EVCL9fDmAIoeReW
         x3ybx/wbdl4VP1FRhVahF4p8LWlW48dLs+IYNDs33ZQVqqdZonIrlE38r29bE7D15C03
         zn1w==
X-Forwarded-Encrypted: i=1; AJvYcCXXMVHjhBgEjvBp3z6zY2s4gbtSdd2EQUVmjv4WUgB3HJnkX+9sUtcNhwBxqJf19KFRx/zIQrSR+eoLg4zj9vjCm7bBsk0=
X-Gm-Message-State: AOJu0Yx7yZ01ZDm933f/yrhBwYu6pCY74Fbv0AnnNe82Pe7SZZA0G8vg
	KukvPkRbwdCbTlMLqHJ6wLWsqTbY3HEGATDMlOR52EKzKGfW1Dsf6x7Os6nvY38=
X-Google-Smtp-Source: AGHT+IEgas2OLJrF7XB2mIgjoehICb7EFSEjFXMukvtNnOS2pTLyI7kJ/AO49Glxml7R7Hs3m0cKzg==
X-Received: by 2002:adf:e6c9:0:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-37194317364mr5779116f8f.1.1724044663633;
        Sun, 18 Aug 2024 22:17:43 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a31csm9428388f8f.17.2024.08.18.22.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2024 22:17:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Some feedbacks on RISC-V IOMMU driver
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
Date: Mon, 19 Aug 2024 06:17:32 +0100
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 linux@rivosinc.com,
 Will Deacon <will@kernel.org>,
 joro@8bytes.org,
 LKML <linux-kernel@vger.kernel.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 iommu@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 wangqian.rd@bytedance.com,
 linux-riscv <linux-riscv@lists.infradead.org>,
 robin.murphy@arm.com,
 Hangjing Li <lihangjing@bytedance.com>,
 baolu.lu@linux.intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0C91D33-8C1C-4C67-B9B4-41206EFD8ECF@jrtc27.com>
References: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 19 Aug 2024, at 04:56, Xu Lu <luxu.kernel@bytedance.com> wrote:
>=20
> Hi Tomasz,
>=20
> Thanks for your brilliant job on RISC-V IOMMU driver. It helps us a
> lot for what we are doing. Below is our feedback on the existing
> implementation[1].
>=20
> 1) Some IOMMU HW may only support 32-bit granularity access on its
> control registers (even when the register is 8 byte length). Maybe it
> is better to provide a 32-bit access method for 8 byte length
> registers like what opensbi does on ACLINT MTIME register.

That OpenSBI has to access MTIME piecewise is a workaround for a vendor
not implementing what the spec clearly intended, even if it wasn=E2=80=99t=

explicitly stated (but is now, in response to that). Repeating that
situation would be a pitiful mistake.

The current IOMMU spec draft very clearly states:

  "Registers that are 64-bit wide may be accessed using either a 32-bit
   or a 64-bit access.=E2=80=9D

Jess

> 2) In the IOMMU fault queue handling procedure, I wonder whether it is
> better to clear the fqmf/fqof bit first, and then clear the ipsr.fip
> bit. Otherwise the ipsr.fip can not be cleared and a redundant
> interrupt will be signaled.
>=20
> Best regards!
> Xu Lu
>=20
> [1] =
https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.com/
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

