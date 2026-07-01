Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D640349CFC
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916626; cv=pass; b=P7wcBBwxWC1HHGeBW8wGQu1w+rocmAyb1pzNVyNNJWvBJ3Ayd84mObJBlLFPMEJ566esSlxJ4d5ot3BNFsR4u9Fv7J5xfGdUDljsm0/dMuMCGu8rGWFe/VNlgHkynfeHhbetyf5BZ5CXCyFReLbj5CWmzBnBofB60QceJjOF7Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916626; c=relaxed/simple;
	bh=uxK3787kwBaK3XoNUtICKMe+9KxBA8wczg+LhmRdR0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2wf6Orm2qOyox9kKnfAoALUBhSwbPF6BbsilhDmNvbA3bJq3zXR06COBUsQZvlQ+bqcjZ3WgICW1LX9prrOkukN+d2D4vKgmyFu9BCj400eQAnS0EClwA+nbDjveVLQcCGzhpc4ZKlcqYSr1z9kgOq4gE8BmU2Ri5RYuunHU4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7kBWSO0; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7kBWSO0"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664cdeab266so921358d50.3
        for <iommu@lists.linux.dev>; Wed, 01 Jul 2026 07:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782916624; cv=none;
        d=google.com; s=arc-20260327;
        b=P2Z4Pi7Sgu95t1c1lGLGo6szDWDpcsiRsVQUhgOD/MBDqmQTV1iIPlbpzddiduBJ7W
         Lq60P7DWEmxF+ksgPuXBA2HziG9djpg1K1e5thZjF9Caqf1BYvnOA0umWDZ4CxutcQDB
         RM9BLrSIglf64RbpF0TOEtobTKGsw/V8j66kYmV73GGiPUDmUjTaZYd/g35rbU5zRnZw
         4vOjYpQ+ah0R+l9sqbfcNNo5TWiLrJStU7aVqIzEFmjG8r5FzBVGVLkooTcQIP1fdKfo
         f1CkKsyIm5p19da1DKYTlDHYQ/iH8W7MwoZhPN3/oPHakgO8Ayn8yFsOvQndsL+uX6Bn
         YrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uxK3787kwBaK3XoNUtICKMe+9KxBA8wczg+LhmRdR0w=;
        fh=2APBCPLmG37Iok7LPJUV8h9i/whNqy+6FjR191HxoOY=;
        b=PCuyMUsjGAE5tUk0j4XZ1zZEs//4Yj5+spHuNqOdCFZ40vBHk27azMI8JWOjuwTYWn
         UpdjbocB16HrPJLI/Bp2897KaLrA95yWVC3UpHjOAmpVHZUIPzlByg0DhjLRjYTh5750
         03XT4MvezaBFAakuPkPLLJcACdxNrEuzQBoZms7Py3acvg4WRjjXOkcoMsTGSGKjN9Lt
         eEjX1O38fRawyWNmL2LAz/tm0H80Z032r872vb7BQjjLaLfzqKSkI0D8qMiolvZv7dIv
         FMlCuHDCGjmd/3pwA5COuO9CSCEoem3tVEoYZcTSfZBZ1aBK9qT2HiXhHXgQBbdhM7OH
         kZEA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916624; x=1783521424; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxK3787kwBaK3XoNUtICKMe+9KxBA8wczg+LhmRdR0w=;
        b=I7kBWSO06gVcm2zBRuO5sn77Iiub4Jcok3RwCqAkoH73Iq1xPPYZFIuLpb18jQvdTZ
         XteA6GWBZRwTOmsMLerWEyJy7M4moQ3Fm1ogH6/hdqDDFV6Jr/ISt4CRaazCHrEoMhJv
         htDkiRkB5KY3f0227OXXW0NAVfF00cI8OHdsJeTOeiDxfepICh7Swj5VHOqx2CboxoKD
         6kxsqw7pFP53vOxP1N3ATbWbDQlDjYHcwkMzuMKBsAdHwH07n7GbR5OHoTR9QRARHzz1
         +NWPIZoeQfEIo14n5SrzywesFdlhdVdVZY1+e9WVsiHlvWIqojRo6NASD8ZW81r2hkZe
         CSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916624; x=1783521424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uxK3787kwBaK3XoNUtICKMe+9KxBA8wczg+LhmRdR0w=;
        b=YysAom5TQL/1Da24kIOk8wNjkDeDsJILkwhcvZ7HXxWqW2TxQ1ttJe1TTE2OP03BlB
         ask2EyR1xEJ+Er6E8QrD0kCUPjdpBgE+tpY60xAC6HJqI194EXJNzMBY5HSX245lu4fl
         Y5rZcVi4bXHgQ09J12UnQJUv8cXdEwwHtOhUVOrFGExLuwlFfsh+9r23hOX6ha57m5FZ
         tfJleJTqQlv3zYxPbkZjdwL7vjjJJ37Zhl/beTUGTMPycgSBasJF1restdPot81G5+ji
         bcgsQtjjW1JCxgOrl7JyRmJrs/3TS3iabOfAFMpk+/vTzdaycDobq4TQMh92Dz6tIOQE
         MW6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqdogrxC6YZoiLLWZBSd9fJf/e2Ly/lUY8aTj4GO3mwpWqGFrIeHER43ZLZb6ERwQbQ7v/boQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfTjF5mJkIJx9Fdui9ylDLVJA6NjDwndfIEf2aIaTHpmyaDXxa
	LuUHIk10E+Z3/p9YHbmPqkQPZZMzP2JnKLSf5yA9AxQ/uv5M5RuSENWl0omLwpPmLSQC89XtpVl
	kCyCN4BlvigaPNAnDUnyspKSFKZOzoPQ=
X-Gm-Gg: AfdE7clzMUTNqVGhKoEb6WDwgGPsqIuMmRtacohKxmyUCw2Xbe7kHQzn/g/w5FVfOZV
	D2/VkZzoSzy52aakCpe23KGKbi3O6KQqSIy7FhefgnEyTHh0b6sbCk2n7HYOvziOCBLKpu3K6v9
	GWhk1Bek2S7vJd97VN44q8wWEccwMjxTC0hxA9GE7udJHkSegqszR6IdJkFkg4PIUHvyY+WlBGU
	GJqZ+qVt2SjXptY+9iXJCMVM2CRb7AISB1qyWWwTsE9AB0p/QP74IWN6rMadWliPaOLYjf3cmA7
	yfq/9W3xRutIoCLbi7Z0jgjdByE/OQr4iwBnhZakp9WDQulJ4e/T3uYy/pUPdg==
X-Received: by 2002:a05:690e:b8d:b0:664:ae68:33b0 with SMTP id
 956f58d0204a3-66521d75bb2mr1788278d50.81.1782916624248; Wed, 01 Jul 2026
 07:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-4-506d936a1707@gmail.com> <20260630-halves-magnesium-856f9c7d60b2@spud>
In-Reply-To: <20260630-halves-magnesium-856f9c7d60b2@spud>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Thu, 2 Jul 2026 00:36:52 +1000
X-Gm-Features: AVVi8Cc_Z2Ec3ueDKeRbjSSEO7FpMbGiHoLBEK8cPVlZ9DBrXWtcjp1MzslxPtM
Message-ID: <CANpmGNs9PuH52ngbZq6jGHuJkoZ=Jz+PRk8Bq7Rn21g9KsotEQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] dt-bindings: input: apple: Add DockChannel HID transport
To: Conor Dooley <conor@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:08=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
[...]
> > +++ b/Documentation/devicetree/bindings/input/apple,dockchannel-hid.yam=
l
>
> Same thing here about the filename. Looks good otherwise, so please
> change that.
> pw-bot: changes-requested
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
Thanks again, will also adjust this name in v2.
