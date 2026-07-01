Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D7349AF6
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916376; cv=pass; b=KbopWdnI678SMGzUqKwCBHsG9Os/UsJ+UTyfrUv65Ivg0k6tOidN/vQ7FJvmhTaB5zWVOoi9/YosYaKxU8F1R8kuuAaQAbfC0tOfe+uQbH9+vAOj6Pun90lZW+9mIVlrwLqDYPwUYyjvo4MWGd1NG6v3H41eVv6Vw/iu+vt4HDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916376; c=relaxed/simple;
	bh=sZ+JoBpUWCF0i/dfiNw2PzLfB8Xqm/+jouOkAHa0NR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8W/fHHfUTCcvI2Khd3W26uv/Eu5r4WpZvdM3BVzf7tMUd8Ku7YBtrvuk/yYElQrU0iPWt8r0rI95EQvvgk4HuENcq2SYpFndYArFIMGuVCyRrDp1wHVIUVVVDGXld4/vTijd/xXDCbi5PT+0oYbt1ufNFfEtjsWoQ3uY3E+Ip4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIwE6EPX; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIwE6EPX"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664ee752958so965565d50.1
        for <iommu@lists.linux.dev>; Wed, 01 Jul 2026 07:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782916374; cv=none;
        d=google.com; s=arc-20260327;
        b=I6JjOPVUIDPE4MrTYEvT15vmvjB0DfCxvDMEmqEoK4eYIzGvGe7SLlewETD6ZRTcNJ
         yL0BWshbbzdbvBMnhrQWiEmUc4M27bZNkx9P1vcBWUsQWfBnhB7azmnyKRIcGUHLaIPj
         nFYtg5C2uPmS1SXocCkWO5aa0NXOZ25e7nB2AQ11r79byHJyUrlejwxlz0TVjZd4bif8
         QQLMOmvozlxxKONWJosIdFaIttppw4SNDs+JpJyyKQ7g/7JGvuywbmpXpVSrxVBmirZg
         MSILbSBIuIBUXAiQQtuZKILsrBXw5t5sXmvgPo2nN/J8jsAHggOQL4AxAECCH1b4Ndbx
         C1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/PMJfwXDmjutwz2ZqUdHqOQ1qGXDhEDRkGoA21ZDRuY=;
        fh=x92Zdt+qKXtRexAAFD4Rpb3Ad04dVB5cJrJLlG96+6E=;
        b=HUKX2oyQ9QFOXy20jLp7Vl4gJe1HnCRfsgULCSVB4vWPO2XNwCQq5OnRNKXARXqXQW
         Cfo1KJiuNgf6lbQ2ZjzntUpO5eFUfT58gXL7Wkxx1Kz2xpS0o2CWmfmV+dbuJqqoeT7q
         riJ7+myTuOdVl71+BFjhyTJNt73kpLWsCrE3drWG9JUX2lEJy0F42ETX1FGD/gLXBlAM
         j/wZY8/d2yNhgqDAIoSrvf+FnRL3mgFMycCKapZiSsvwjj0JSTOFqQqCkcxbEOVDaaFO
         6NmN7SE6ehhxnurffFb6VSrCULT/c+ATGHTFdu5UCx+gRZVJTlS456RNlRPmUacRBj3m
         JQKg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916374; x=1783521174; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PMJfwXDmjutwz2ZqUdHqOQ1qGXDhEDRkGoA21ZDRuY=;
        b=jIwE6EPXO1umJx6of1gHpwhDlsmthcYdKGr/rd8IKfLaQhmJRTVKn0qDOifLhZsae+
         ZT4yq9TlDfy4Gun5gSglyNy5LmaimF84ue8ojFw5KkfPq3SaWCmCsjdR1wsgo+3K5QF8
         E4wyX5yGmOCGtdeBSDtzEUYzhTX41Y4bFTh2YtFjwm9cxh1A3ZO8PXNsCD7UvXxmRfgi
         chy6DzgPX5P9APBZAnJ3J79sRt3zaKx09u70KUt162Zc2FCH/6nYocvG7YMhymfvPFuz
         w2d1/Qrkeivr/IWm+r7vjdDHIC6IbSsPVhEIDmodV4XsEFwOdfv67VObYDPABAjDpBHr
         l8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916374; x=1783521174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/PMJfwXDmjutwz2ZqUdHqOQ1qGXDhEDRkGoA21ZDRuY=;
        b=OhpaYgGcP69paXhJevywf1LgNHyorKud9I3W6bf2qNpcqlUfgOvmz85bAu3HI14beO
         0ECSheCLv6kXsELBdPnZG+HUm4+6pmlMifwbU4rcKYCOH88FnxVcitnNblwDv1nmcOqc
         MSYb/cQJWQeKVGpURhv5TfsZc2Dul+ggcLsh0jR0R0Uz87ihunMywurgp+vCWgGLRfyX
         ZmZYrpY98JxmDVqQbMfeKVc1G01lQUGSKsVufnJRGL1iClfNswW4hMEdK8jjPYXBPauD
         mCN/5y9qfUR55tibNjIFrILLajRWLVSHpu6jLoySPLKSZC615HjabMgQG5dpEDwMtPuP
         p9lQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUQdCSNfdy6LN/VR6ivyxWZist0FvG6nfwyHgaUsa4eodA2jJxz09H8piLfJBcrn2HqHigEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwY9HaHUb8iFQ+RoEV+h013EKM44gRyEzpF59qHBiHlatsWwDso
	3rncxIo0pH6oV/hsVIgHLv/34s+IIqgY0SuLXHQkve/XWakGmkWhYPgOXaA8muG1p8mv1WsJppY
	DIzieX/7QfD8ri2VUQ7s8qVtZNjO7WUo=
X-Gm-Gg: AfdE7cmeTdS7PCwv1fyA6T+ymmaTWC17pgnvlpBglZt3LyS41XrloIEwTEvYJkPMvka
	RYnzp7hdWJe+d45AKc4LTlwTswy0DDV9O48FCWTaXJj2LIyxngzcAjkqMEKTSdiBRpITbqNTxa0
	B/x2tvCt6NnJM8MrNz0vqcEcj/SO7bimTI5Gej8+Gwz/cQIunO/V+HmGstpz4yD/oAddp3/60Xn
	Jety+FcbauTVemelJPZ7SNSN7+rt3zr7SWixcRh4bAaeBL3o5WkSkNo//qnP2nmTsswGIDajUch
	Pcc0ezRPf0zQH0YPnEyZdtfpJEafAACZWC13qcWrVdEjYdEIBTb9yNU+sQPlsg==
X-Received: by 2002:a05:690e:bce:b0:660:a41d:d175 with SMTP id
 956f58d0204a3-66521b945c8mr1896345d50.55.1782916373989; Wed, 01 Jul 2026
 07:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com> <05d39c4d-8405-4fe7-a798-c8a9c92699ed@cyberchaos.dev>
In-Reply-To: <05d39c4d-8405-4fe7-a798-c8a9c92699ed@cyberchaos.dev>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Thu, 2 Jul 2026 00:32:42 +1000
X-Gm-Features: AVVi8Cf357Gij5feihuaNZJkJ4WRqS0nufoZDV_3Bt4D6iI9pAVwxlHJbwtr7a8
Message-ID: <CANpmGNs3s2yLw05jkpZ9mscQNZ9JvfbqEgyW8V=cMD29aU8c2A@mail.gmail.com>
Subject: Re: [PATCH 08/10] HID: apple: Add DockChannel HID transport driver
To: Yureka Lilian <yureka@cyberchaos.dev>
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

Hi Yureka,

Thank you for the review and the feedback.

On Tue, Jun 30, 2026 at 11:21=E2=80=AFPM Yureka Lilian <yureka@cyberchaos.d=
ev> wrote:
[...]
> > +     strscpy(hid->uniq, dchid->serial, sizeof(hid->uniq));
> If the keyboard appeared before stm, dchip->serial might be uninitialized=
.
Yes, true, thank you for picking this up!
[...]
> > +     /*
> > +      * Prefer to enable STM first, since it provides device IDs. Some
> > +      * firmware versions do not expose STM, so let the keyboard start
> > +      * without it.
> > +      */
> > +     if (iface->dchid->id_ready || !strcmp(iface->name, "stm") ||
> > +         !strcmp(iface->name, "keyboard"))
>
> I specifically asked for a mechanism to let the keyboard probe even on
> devices which do not expose/have stm. Thanks for adding that!
> However, I think this might need some more sophisticated mechanism to
> decide whether the stm is still going to appear after the keyboard, or
> not at all. I'm not sure if there is a way to tell this at this point,
> or we need to add a timeout for the stm to appearing, which needs to
> expire before we create the other interfaces with fake serials.
>
I do not think there is a way to tell at this point, unfortunately.

I think the best way to resolve this would be to implement a delayed work
item that is scheduled during probe. If STM appears and initalises before
the timer (I'm not sure how long it should be right now, I will prototype a=
nd
experiment) we cancel the delayed work, get the real serial, and spin up
the keyboard. If the timeout expires without seeing the STM interface, we
assume the platform does not have one, mark id_ready as true, and
proceed to init the keyboard.

I will work on this and experiment to see if it's the best solution or
if there's
any others as well as to find the ideal timeout, and submit as part of v2.
[...]

Thanks again,
Michael
