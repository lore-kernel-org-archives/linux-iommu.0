Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E602571D7
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570072; cv=pass; b=JibO0QuljN4as4qlWLUBWAk3dIgOxeWD000khgMzCXjOU+OOjJPr9PpZOhofL3KW9bMnqsUAccJPFuaQWezCurgrpSDcnvkCVQsRfnvU9j+YXQgYYgzi7n1tplNicPcU8flL465xQaHMGay57KST0OEiEVjQ7uOxRI0lZQ8ZlrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570072; c=relaxed/simple;
	bh=+Y/EbmTroEIXOb8ZGWkBw+yCbLIdIXqj7d3eCXNZMxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6Ft4IBwFw8ydHD27bUGt26oZjkRInBDkC52UL9hFNR2rn3gKnoe7jNUBcOaP5AVHfC4xttPMm8oAIMrHNSc7qFlubZ+NGo5gG2wEQ+3f2M3f/0e0DYEfXH0AQjDwteW6b4AFuTYYQU4hxI2qSZnFQ0OmfBHwUvBWOUoLWhhnbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dr65TquL; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dr65TquL"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51765331535so73611cf.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781570071; cv=none;
        d=google.com; s=arc-20240605;
        b=UBiG8yDG9miekC2fe7spOm5+fRGyeL4cRWo0yaUi/fb0aodaWa/ILXX0QZBjtkjAvf
         MDsX6uW0RmpxV8wysTARVx+iv+TUz9QwOiPOnfE9g5F+3ULscFQbVGuHDAdzGbRA1OZ4
         No/Xo0NuLM4N7z+FPM9zvsc0gCrNsCs46QxAwVpZXuoqlOgIr7+pJXFfmX7NN1M7i5wf
         P8EVm/L3kZU9YjMOw40c9z9d7CkKBhQ/BQUgGe/Ru8Ht/53iRmPZFlatIGWHpWYoQvXE
         YEtesbwfWJsQ6CUT9fu2N6jnOuJ+UGzBkVMkO6lw5L7JlmkTyApNXPNizcpvPTg0lftA
         SI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/kMYwPART6TwqdV2FoTP7myUd2KBImzKngAy+xn3I78=;
        fh=FnsNvceL6drWn/txmSdHG/oICWrrOhtocfhQIpp8Z44=;
        b=kgTR6mcm8yYvbPON0Nnu3PMnNQ6yGI2JlPgl7Y3X3TuvkCfaTLz6yeh+A8fgpZNsHE
         WD3lQP5cADBF97USl7RrD1BkbgVKrJZr3oJYgOCQ1KVceTSZtvIqRgzZS/wrlg///A75
         a0NamKmb3+kW4Wraw5F1+8dz2ylJOeNxgh6rmTvpDlKNhCllvXhQPkAvAKYwvcJjxQQc
         2GZrfWN19pYtkKk9LaXMEr0fQWWnELBzdm4x4ru4OgCF8tij7yNnr1p2SujYef1yLuVC
         8mjllDAAwXVLcAGcTFRAMJQC3dlGdlFXoe7KSooxMDEV1kuxYicsmEo5nb9dhJ8OaFjc
         4ndQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781570071; x=1782174871; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kMYwPART6TwqdV2FoTP7myUd2KBImzKngAy+xn3I78=;
        b=Dr65TquLIOuepdF+fRRk2FwEy8qtpBLGY/ukqavm57JVoDSayo9NadmnWfaoNhNhcY
         U5a3EW3q7LAivjcOX20Lv8holNq/f3TNupplxvp7Pv5SzcnLPwoexORiBYSwQwy5C951
         uxJ8winmkmtGVTLpakryKh7VqDNzeQ77G/XppUCE6N36p1BNP+2yMR6io6176REE97Rq
         kLYgSSBYC6R3ZHSGTJLQA6xa2/FkrFvgH7DJJJX/Ifix6GdnKARBN3SeWMuJvmeu2bhl
         Z7qsEh96C1JvxhROuertTk6liuNEjtsTSgzsfQ/II82XqEPNkuFVe6LgHg7jbwj43gxO
         3tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570071; x=1782174871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/kMYwPART6TwqdV2FoTP7myUd2KBImzKngAy+xn3I78=;
        b=QuHKJhHb33kWNMItBYphow6QTgxgDzIR5PteRw93D4cw0bJP5ud9wYFM6vRUpg4GDa
         tTkGuzykIptYhqbF2KdGaFhaZbL8iqwNgFpzkN3qzpGC1D++wjc79kTUUkh3FAbGXGUn
         AeVPcXp8o7jGGxeWnZtiBKawBR1XQKQCWWN+fPv+ujY+u+QlIEoA0zn8PrGP5HDgRrJe
         J4Y3oDZhvRbw5FIQ+WDel+yvpjsf2J6r5VjWg+2q6Ffih11y63opAmsfNYCS65OuvB8u
         L+T/h8NVLrt66/NtU2+CiFN/FlNTOYnVheQ3MBn3Py5r8NpGRss7tdyesQYj+LDIIgoD
         HkxA==
X-Forwarded-Encrypted: i=1; AFNElJ9z5pkqaPSoW5AFeE9RyxzM/bu6wyOtrRy8FLuGKuu79wHLB/+fQ9xFvnCe+HZkOVDa3P4w7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpE92AFhNIXHEctK6JogSJx9afEL8h4hHefdj+AN/wzy6+K2TF
	wJcXWeMWXaaqxpjUH047Wei0szT4Y1ycsmCVIcrcxumYNTvT2vbhQ+A+SdHUVrQqsyM68JLLadV
	YdirMvPjsZB4vI3+3XZdR+WSRs0vBPSNyrY5R2OFD
X-Gm-Gg: Acq92OHaCwSXZmq7oCPn785twedqIDtO5VDtPQUyurTtwPDa9QhM4H1h9seY9FyNLXz
	mDtO3q4HeMZ0BwkDLu4em2TD8Qivt9bXF48geC+TeLkRcuCGi4tf0CL9uDWkzxHMrrx7l+jFb7b
	eIID31OVs1zd1F446vsRMJYfAjR79sxd/lmSBtVm1x/bi4fApLwaJUd6KHT0uD090DSWhtWFeQA
	/foyvGcXXTAn1nB/G8xmS+Ft9KeffF2PkuJHp1lLxM166LkAooMoMDqNnxrE35c3CUnWgS6Spgr
	tau50fk8LcDYTlaMN7M=
X-Received: by 2002:a05:622a:34d:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-51993a1cd68mr2473791cf.5.1781570070183; Mon, 15 Jun 2026
 17:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260615172535.080cf94f@kernel.org>
In-Reply-To: <20260615172535.080cf94f@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 16 Jun 2026 02:33:52 +0200
X-Gm-Features: AVVi8CeOrOUpK1NsgldXN4SuTTNLIo0M4rqMqBljDIv29mZJLe4IeoAAQGnLuGg
Message-ID: <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Jakub Kicinski <kuba@kernel.org>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	willemb@google.com, kuniyu@google.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, david@kernel.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 2:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 15 Jun 2026 23:42:20 +0000 Luigi Rizzo wrote:
> > The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> > especially with greedy senders, this has a high chance of happening in
> > the softirq handler for tx network interrupts, creating a significant
> > performance bottleneck.
>
> What's the use case? I associate swiotlb with debug / testing mostly,
> so it'd be useful for people like me to explain why you care.

Ah sorry, I forgot to mention.
swiotlb is used in guest kernels for confidential computing VMs.
Ordinary memory pages are encrypted and the host or devices
have no way to decrypt them, so the kernel must use
unencrypted bounce buffers to exchange data with I/O devices.

cheers
luigi
