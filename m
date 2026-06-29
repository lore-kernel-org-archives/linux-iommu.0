Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A2404BCB
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739211; cv=none; b=GeEgJ2F3jSJd+uRpO7Ce4DV1jDQg/l5axNhfKadxXO/e2LEUbGeAlOJ8bEhaJayPJz2/Uv/jbYpPBIkz7lfcL1StEiGTQ7kkBzxlxIE3PITHbui+y4cO7DCUwa1xPjI2ZvaU9Qw6vCz0E8QYWyqPcAd6oMZ5cxYD+lzIpBchclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739211; c=relaxed/simple;
	bh=+A+RUJTLJrGbg9VAv0ThV60lYJTd/ycmh9oKZScdsCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP14gNHPgsWwzV6PnIgxw3ZuvHEwX7F5P/n+MDuMES9kN/KSDtqhEOG/zwTLCMpkc6d7woEUraXe21iFn3DmoWXOrX66x9qncv1ierdOawzb6QDaFxqf/2p2JBeE4NrQu6fCC/Q7KOad1HWi0ydhBEARVsg8mgtDrppBEGVoyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtDRmQFK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtDRmQFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782739209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+A+RUJTLJrGbg9VAv0ThV60lYJTd/ycmh9oKZScdsCM=;
	b=OtDRmQFKZA2q6ygtKSUlgzHK9spa2LQQRT31F3Gj6cYGD5ynZZRzbThUO+Wv2RJ+XDhKSq
	lAJzzYWbdTjGtPr6iUw+L9nase0py5r7B3Gkb4vqHnh9N5aBRuD47OtLV5Zi9g+BjRzYKJ
	HVrqniCIiSmLzP7x54jCzB60TeVJFYc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-KTP5NV6FOdK8c0nLeGOj0g-1; Mon, 29 Jun 2026 09:20:07 -0400
X-MC-Unique: KTP5NV6FOdK8c0nLeGOj0g-1
X-Mimecast-MFC-AGG-ID: KTP5NV6FOdK8c0nLeGOj0g_1782739207
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-485fdae1db3so3914810b6e.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 06:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739207; x=1783344007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+A+RUJTLJrGbg9VAv0ThV60lYJTd/ycmh9oKZScdsCM=;
        b=HMjjd+pJGCw65ZEtH18MdE76whRh8FvcPNha48ja+1lUMtkNkkPNmW6F0BLPiM400z
         W00wAZG7UNAev2gGriWMcTugUdUvV67TJc5kAIJuws68enUYLs0xzarIFe9SENiE95EU
         4ok9SXLKoSYV9dP+qsY9DiDU7t/Lxr+QlQiVALuVXUwju1zE9QKa8TlKvb9eyQ0ZYrU3
         kLyUJk9teo8uhW/9/6LefbqXgv2TJwxOybcg48Mkn+AfOjHV5oujh4fpP8/r0xAcKThQ
         MU4mDgTpBbnZcVajjbx6vDGAxrxij0TZKQ/vEfp1qzGRdFGKbjuJTuUeon1N+aXHZVRR
         4W4w==
X-Forwarded-Encrypted: i=1; AFNElJ/9JU4GWUkC5kizwzbzwqY+fDEGc+7Ws8/uVwrHm7Znh8aoR9BCqceQoayhxdoBCCw/uA7Uyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxQDc8VrBuoHJqF5udxL6NFuUa8E4dGTFmSlDEzKQmFmNQBUCM
	M7o3EaWTUjz+OnLFLSf1hS7LXa3qRgSoo1VtWiAzIPpN1SvoxRTc0vbPvQ8xl/USHULFU8/svH7
	+4vzrd3JWGkPXceRgvU5ErGEsLeRck43mg1AuXHlaaqXmUW8PI5NTA499RBrAjB207LWr8G/hH+
	/0KmLjuc3rRoymRnhWkLboBygfCAiOiGw=
X-Gm-Gg: AfdE7cm4bOfZViI9tKWgmP/Vl43/Yfqk6zegtQmZxQBNyB/Ub3KI0jFEYj6+5U5SmQ3
	mCnUwMidBl62h7ULlmPh4SDL3uSuNiVubcgnuZ5U6fS1kSJSKRWQ1jI9X/oPofEfYXSUMafLQkR
	8DgFwNdPOjTif/08EXPRJz4RqOZiLaS5Y2UmpzEB7wHAg9pCq5AKt7jpKBOGZrdUx5r2mLz5ZUC
	SxoCUE3n149lHKWMsL1v4QuC6J4
X-Received: by 2002:a05:6808:c229:b0:492:285c:4dbc with SMTP id 5614622812f47-4943dfd8b2emr7701005b6e.30.1782739206973;
        Mon, 29 Jun 2026 06:20:06 -0700 (PDT)
X-Received: by 2002:a05:6808:c229:b0:492:285c:4dbc with SMTP id
 5614622812f47-4943dfd8b2emr7700980b6e.30.1782739206188; Mon, 29 Jun 2026
 06:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622133540.48591-1-desnesn@redhat.com> <CACaw+ewAhmPYxnQgpzh-zL823YEuyZGDukwAzeDUOvRU9RrWcA@mail.gmail.com>
 <be228d1b-f4f8-4cc8-ab35-717571d0db36@linux.intel.com>
In-Reply-To: <be228d1b-f4f8-4cc8-ab35-717571d0db36@linux.intel.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Mon, 29 Jun 2026 10:19:53 -0300
X-Gm-Features: AVVi8CdsM8o1m1mnm4XRVJ9a4Hx4twvCmdvxj6ov7z9dn3EC7SvcKrUgKnuqktI
Message-ID: <CACaw+ewcs2Swx1EErF9JB3a8Da6WPhXwsSeqbA7F+ZpcFXAuAA@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix UCTP context table slot when copying root entries
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org, dwmw2@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VxtR-i6CsPgV-Y-eKNFnOl88ESJ0h2VaG2Kadv-F7Bc_1782739207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Samiullah and Lu,

On Mon, Jun 22, 2026 at 10:46=E2=80=AFPM Samiullah Khawaja <skhawaja@google=
.com> wrote:
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks for the review Samiullah

On Sat, Jun 27, 2026 at 3:46=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
> So this not only addresses a DMA fault message, but also resolves a
> real-world kdump reboot issue. When you send the next version, could you
> please include this and the below stack trace in the commit message?

Exactly!

> The change itself looks good to me. Thank you!

Outstanding - will send a v2 with the stack trace in the patch log.

Best Regards,

