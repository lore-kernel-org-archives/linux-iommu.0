Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BD33B951
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936955; cv=pass; b=qOsBk5yEUkMqz/WoZ4dpwsws+akarJsuEva763OWXm9H0I0AkYmkZANHFbE6NnCZ33SXIaux1qzDzIgs0Vig6EhJlGs9LGp1ufh9GYtBSBgpX/ha0hfEwbqBWdpzROs9fBAulY6Om2hlBMDXLNObgVXRohgnv2DtvszX8ufLtrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936955; c=relaxed/simple;
	bh=ljYjSOU2rttv7S0DEe0C0TY92PtkIx5fBTSkNK4qXpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ka/agMFWOTQuCLeEHZUGr/K+zonW9sDoiDifIibK1IHA8QUCqqe2oL9fr2T7CE3/YfuyGe9fSOyTETN67qT++EvwzC+s3CdjpsQIWS2aac9WcE1daqSpg8wNitkFvZhr5xjMGdHxglv2hyHCoHlux8a92Ax3dY/KfcIlEqdiKt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=gQrXd5Gy; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="gQrXd5Gy"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb6573bd52so1662515a34.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 03:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783936947; cv=none;
        d=google.com; s=arc-20260327;
        b=cr1ZZ1YkHa9qmgAfcm/21r3n3Uzy4ThDU6acy/5cugvCHWLXXMZXG883mSlJGWhyT0
         UEqTsDkhr/rHe5Xz9EiSQ+IFuqF5ta8cs8fIx6SfL48I1x5VkAojKikf++iPTq6OFiqp
         w0KBq53HpsEwhZpz2WONxM0jAFURhqVbVsBmoJQAEJFkF9xIEVuMNP8f+phHRS7G39hr
         ZNJ09Dazxwc98+4sBg7O6jyCdSQV+z6NP/xUb+xBWzu5EE065B8UAU+ndcWF7rtpYeUu
         zZY8fQ8oXVW/jaPWB/A9XjWOi5fr4jZPPliFLZr0lBZEjZco7PEjfQrPI+tdS5Iwj+/C
         UdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2P0GCpX7xQ5SgWYiQkKz/UKhv5/hqMLczhsTlA66oGk=;
        fh=0KtCacvB7/88O82iWh6qouWj8jLD6tjErJxx5QVbNn8=;
        b=iiJz3G1qQqN1DyBoaS1/sDRD7N8Ir3i4hnTLFETLmGEsZJs6WKNVR57tS+9mG6KAa5
         Gsw7jun4LlOwYXByAomt66wya5xt3i86k82zkEFDutCAAewe+JIkUIFUjjQ2GO3ui7Z0
         lSgXUAi+Mb1wABI/VK1kuMT60gKyTFWVwvyihR4kD95zZVbSpZH1dVqo9MyuEE47d+al
         Mv6zIXpU8J4lzkIkhevMJTTwB7QfY9slq/6qGcpHCVKUSt3egXrNz6i3F/OjjZt58hCc
         HbklbC7IFMzmaAObE+UyS17am8ER4EuWMUGQhj5wnXxstxg15zH9+pf6uQm97/Z89Gsw
         Xxaw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1783936947; x=1784541747; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2P0GCpX7xQ5SgWYiQkKz/UKhv5/hqMLczhsTlA66oGk=;
        b=gQrXd5Gyq8z2dOvOKnCD9f/sXuboV0e67+ZQAq8lD0FThs+Mm44mM+VXC87UwIRmdJ
         1xql/VBXGG3yXIpAfr/hWlD0Wh4Ang3UwG7k9BnfxJeTFmQlo+ssqmQPvnTUyl06w6H2
         J/v8hX2P4uNSqxzit6YEIh/Dov8Chi7yiGOnCUQYEl6pPVEgTa/oAzkBswoRR9IAv7SE
         vRh2bT1AmRVqSbki9G2Mw/JN6OaLRC5EW60wCJT++4mj4OdL6EKwstY9XMzvUAh1XVJf
         TKK0ulkgV2F++pgeuacDdoENucc54R0MsQTFPQ2sBESbm1p952QylUNXqJJQ4P1Nrp2Z
         BEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783936947; x=1784541747;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2P0GCpX7xQ5SgWYiQkKz/UKhv5/hqMLczhsTlA66oGk=;
        b=n1JArRGFolgvjKxMLxUyUhwcQt2f7vLa8DjNzF9PlSAbtEWnr/2MsoV50uZf8lmPXW
         ExqDCjDyOSVvVAeWiqkED0InNA/NrkwaKN6K+UoGczw+UydWdZezPFIszbRpJWLCyuoD
         y4HMz7qIsfDG9/jeQ84FNXHcdce+CzV05nG35CpHCdAI3xAJoK8+exJEsxGXwB95/svJ
         CtL6uk8yu2EkJHgXnIsc8Sd+QcL2irZW6hGfHzWiYfGB6Jhb+CMNX7JLQhBaYA9S7z3G
         yUVRYFhGWwdTM44rBAgFrSqS/KZsNMR5d+Ygy7NBKJenNmPkHCPscPWPrknZh6O93enw
         b28A==
X-Forwarded-Encrypted: i=1; AFNElJ/ELRzGpX/v3IGeLlzxc+4qi1P/Ulzv2dC4o2a52fyqBduj7jq6tupRYWBXLo8rs8ieIoJZyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFmqVUbTRnWaYIL+Uq8gyLAHhg4M1oz7WiamOGgk55RgYdbjH3
	9qwZTcHK1WhBK0z6jkWE8qitZY0sAJJUNr5v01qaH3zXcWJ0xd0E+IvM8xYPXuPBlB0T96pZDtD
	wWNacj5RZ4dyyLjCZMJLF+/08A6zPSzHieR1ATzPNyA==
X-Gm-Gg: AfdE7cnhgFgwr6C2dt0AY8nLR8QQ0khY12zH2YHqS71s2U+UVeaA/kjj6ybvFIipCXP
	RquIQWbr8At7ksi4ck/aLldPZtOe8cwE1x/Rkp6AASI+Izu0nsZJeQsST2dYnKxCcBtu20apnAc
	aqXdajG9sPV4zS+m9I83nsr/DYav00JSlaUWm9JgFvk39+gwL8cWAu/c98FGVZIL6jwWQqTTo5O
	RmQewjh+gCIMOgCm+PF0GLYdFXR70iR5RkX/Vl/tplC3pt1wjlMmhHgBQGnVpPZL/zmMECFpQFB
	wsS8gqDU6SFlAofOXQtNfUDm8WEI
X-Received: by 2002:a05:6808:1b99:b0:489:f199:42bb with SMTP id
 5614622812f47-4a42ac1bf5fmr6284861b6e.8.1783936946808; Mon, 13 Jul 2026
 03:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net> <20260712-bcm2712-iommu-submit-v1-4-80e10cdde2ea@reactivated.net>
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-4-80e10cdde2ea@reactivated.net>
From: Nick Hollinghurst <nick.hollinghurst@raspberrypi.com>
Date: Mon, 13 Jul 2026 11:02:15 +0100
X-Gm-Features: AVVi8Cf4LGOVn8UuEl-XzGEtPWPky3oSnqvul0wqNroMw9il-m2qt1JpocyTw0U
Message-ID: <CAPhyPA5CqCzsDZg1_Sfr=EP5G6uLnnvDmdd_REZPX_VpwS=VJA@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu/generic_pt: Add Broadcom BCM2712 page table format
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Sun, 12 Jul 2026 at 22:19, Daniel Drake <dan@reactivated.net> wrote:
>
> The BCM2712 IOMMU implements a 2-level page table format. It is relatively
> simple, with one unusual aspect: leaf entries can only be installed at
> Level 0.

I should admit that a single-level huge page mapping is possible, but
I was too lazy to implement it (and haven't much tested it).

It can be done by setting bits 31, 30 and 28 of the top-level entry
(all other combinations of bits 31, 30 will point to a  next-level
table). The page number is in 4K units but must be 4MB aligned.

Regards,

 Nick
