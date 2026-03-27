Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29F194098
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603724; cv=pass; b=gl1xmJREGPL4BOz59ZpIk4CZEwMppdUszY/fAU2Wc2j684eCTE5z0dNiGSH/Gi4hP6aGHmdDhw6sGTxEpr8DQt9tGMfLA42R851OcX0w/KqpjTGvli2qeV6lNESaTPW/kRfoQxfULwKO2NF4kc5F0169Omxy8yogizEJ4eCMeKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603724; c=relaxed/simple;
	bh=7oLMUuPupb+L1Op6HEPLrQmwMosRD4AdfgnjTNss654=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foUAVkxerx+d+LslrdsbuyXjo1NYtrlAiUxRUbZyrbh6tmkp0Ug/vKQA6w4/dUqGi2XvV9KRRiXSkLkcww4ORpCE4KAuXvHP1L/meR0AmuH3nq3OJtAfZZ97z1NpPnL1d+iuQ7TMUv3QGhjrWmKr5Mk48cvJZewGQ4AKQGxlVEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHuyyv86; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHuyyv86"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-126ea4b77adso2631775c88.1
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 02:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774603722; cv=none;
        d=google.com; s=arc-20240605;
        b=Kk6q2lxgBr5bWxVtVD/C7niXPFRXcoeAqtwT2o6cdz/xm85uP48GYIV43MG18ankz5
         LAZXZjMzvFqAKyxyeUSafdzpXniL7asQXfIZkmwHA3k4LBk7oB9aY4JeX06y7QaFkclx
         Ykabvgkp+PDK5peus1heC97ZisyqaPJ//ifASaND6jkRd/TX6EBmrHbEeNCxzsvDlLgo
         trQpTt87OIGiUw1plZYEVzNgMdZnPdqKf5fLqVONDFMLogPMxcjsgs3EvD6cON6Ojl4i
         NBDgrdcdZBdu9H2PVD6bl5HjCRnnnf7Zy2ECxswzrx/cwWanlxlcg+IYPzOMbH6XhkMe
         YOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bTqiO629e4vaqODkR007sl1mWS+CoRfkjGQNvwUfTFI=;
        fh=FaIvvTLLPUh3vWJIZ84DWP6qdRfMAU0MNrg1vSlnIjw=;
        b=HKV0GSHnJ8HUqDjsJ6IQUFJ7DdckNxVLJvN4jvZNfcDT45Fcs1nRq13N9Zj/w93t7g
         bWRqECupbXjzCE17/MwgyOgNMPnNB/pfjxnED3DdlNu2jzsN2aSZ+5d+Rc6UdFx2VHI+
         hIj/RpMQDfvMrbfjAtKZ85LHG6y32jxmBAWSpqsnFbz5+ABJr3xzgYobf4KObGOBSt1Y
         SLjELOcUQJRgAld3p2YyHBqsKW3x7jCeJ57XmT5/tDBQBD837myCbzboLkqJc4GMW1V2
         1BCPEbUsYq8Q1vp4tn6y2px0uPLlcA1loPloxQMGIkZiG9EVxoh9cBRy0TzC8XGIPvUT
         sfmQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774603722; x=1775208522; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTqiO629e4vaqODkR007sl1mWS+CoRfkjGQNvwUfTFI=;
        b=iHuyyv86HkQGwXCxHvHO9qaAA1xr+mGbegmcy2rmI8hwyeGb5S13bO4cIEytQ2tI5I
         grhrWlKEsabKEWhLYkz0QPduMOS/ze5Q/snfCveADPGHwMuW5Lf+n8OMzYAdUEpZB9xW
         1/WSiHSVyzydP1kD4hKsEMhySZsUIMssovD8ORC9EG/waNZU/iQ63JVPC6oAVLlP280e
         qh7n5Ya4fylybSrEbPalk7g9Xx6cuZBD1vWtA/UvDMwA3u9LwB5L28BQzzWXbIXXfwGr
         rgSS05NEOVkyjDIcKczEHb2FdDaGRWw0Zd0CMc+3OVcJIagUY+aZBFVwuvAyCIh0ZnXd
         Ug7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603722; x=1775208522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTqiO629e4vaqODkR007sl1mWS+CoRfkjGQNvwUfTFI=;
        b=PiJc7thSdbvbgoKFgChfPS/qgvEB+YUHOu/+ef3m3NZMFHekt8xDVl5BCBPV5rPgcB
         D6Z5LGIVezQ+706kOhAIlQnmQGo4/eAQAXqoNaEeTesYxgTxSlrOjWhUckrV+B7QprEG
         niT4Wq0J9NNVcKQ1Trvwf3fIJ+UfXqtwOOeVpsai2lLrsfKEu4aNGOiAJUEFGDbvZFcw
         /slOhcxkO4A0JfUc8Dlxae23yLbcISVbnf2vE3OjPdZCChFhjKcoRK/A65XxkrhOkwGU
         XSBYmkRLEdUibt82R0StN6e1AnY4vnZXCGsXpG36jeX4bJZ8NBEneSjUeuijk4Gd3XKP
         TjPA==
X-Forwarded-Encrypted: i=1; AJvYcCV5510ztd0PYsr9cym3G+FSBcwF7VhHtfamGLSx3KXFzJWD+3lUdHmtQhqVFNOsW+LYG7S57w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO9teSPRCENozLDDbfOpEHwRYFruM1BbYUi6YAIKWQY65t7f53
	Db4kVZIgZS/tQZqWmYTnCsxa0L6DBjp1bRIpWnWK6CUsPWH8Iw6IsZ4AqQ7Aao8a2cn9jH0Gm7o
	y7lLbYHpSUmmYqC/0nF2yG6PVH7Okx24=
X-Gm-Gg: ATEYQzxihdkbGlVm3hCnoOUxKFfpeFO/YsYvyVCPduEvLyexTwCf3JrMvvXI550um2E
	XCZw4fXsxqt5pIWWqiRPncXxOEzeInA4AGKjMiy7S1WYoPXqNcp73qo8TIKmFpy9wIgkA11l++R
	vuxrbU8WYDfXTwhgDjvh6WKrpBiIDoMcqJKl5a8N1iaMbcb4D2VITlgMmKG8qSfTMslkAluAZKH
	vs9S8FMUyC9frTilmMrvYWRS7/sLxRwo9ny3EHVX0fQzz1+0RqR2CxWrV46kwprfb+ZOwBzCvmp
	nKhdQyo=
X-Received: by 2002:a05:7022:4582:b0:128:bf8d:44d2 with SMTP id
 a92af1059eb24-12ab2857b7fmr889191c88.2.1774603722002; Fri, 27 Mar 2026
 02:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260325075649.248241-1-tiala@microsoft.com> <20260325092200.GQ814676@unreal>
In-Reply-To: <20260325092200.GQ814676@unreal>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 27 Mar 2026 17:28:23 +0800
X-Gm-Features: AQROBzBLnwHEzC-aBHT7vCI91pnunWW4V0hYH-fhfBRc9lS9WxOctI5Y8moHTkE
Message-ID: <CAMvTesCoRHcKip51j9H_WdyL0ggHMDaHUtwyEGo_w5n4=54_VQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3] x86/VMBus: Confidential VMBus for dynamic DMA transfers
To: Leon Romanovsky <leon@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, Tianyu Lan <tiala@microsoft.com>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, 
	vdso@hexbites.dev, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 5:22=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Mar 25, 2026 at 03:56:49AM -0400, Tianyu Lan wrote:
> > Hyper-V provides Confidential VMBus to communicate between
> > device model and device guest driver via encrypted/private
> > memory in Confidential VM. The device model is in OpenHCL
> > (https://openvmm.dev/guide/user_guide/openhcl.html) that
> > plays the paravisor role.
> >
> > For a VMBus device, there are two communication methods to
> > talk with Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic
> > DMA transfer.
> >
> > The Confidential VMBus Ring buffer has been upstreamed by
> > Roman Kisel(commit 6802d8af47d1).
> >
> > The dynamic DMA transition of VMBus device normally goes
> > through DMA core and it uses SWIOTLB as bounce buffer in
> > a CoCo VM.
> >
> > The Confidential VMBus device can do DMA directly to
> > private/encrypted memory. Because the swiotlb is decrypted
> > memory, the DMA transfer must not be bounced through the
> > swiotlb, so as to preserve confidentiality. This is different
> > from the default for Linux CoCo VMs, so disable the VMBus
> > device's use of swiotlb.
> >
> > Expose swiotlb_dev_disable() from DMA Core to disable
> > bounce buffer for device.
>
> It feels awkward and like a layering violation to let arbitrary kernel
> drivers manipulate SWIOTLB, which sits beneath the DMA core.
>

Hi Leon:
     Thanks for your review. I will try other way since now DMA core has
not stand way to disable device swiotlb.

--=20
Thanks
Tianyu Lan
