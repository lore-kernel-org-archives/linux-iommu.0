Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0E6D24
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 19:05:20 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id a1-20020a4ab101000000b0044acf001f83so15341ooo.10
        for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Vy5HkXsUeiVT5tvBi6bh7Myxz6JGg1bF1CT6DCfajZ0=;
        b=A8u0sSIvwwJ0VYwMS4Ptnw+CyL3UkAPrZ6EVO7PAd29O0IAgLtANyPq6Xbnnh+2xd7
         gdPYSP/wOTOVOmjjobUwzI5qOEVw3cTXXdgG1r6IuV1zD4OzTvuZ5KiDDFSLsZUr2f3x
         fMtYxvTaYzaFsIa78oV4YEZWTwI9xqtQ8Ct09HpwFAQKgAtTtZQfEvgyyiD2xKqUdRCF
         gpTVhvFS/bMWkTmIUypJBKta1/KoZ4ws8y4zAVmOOUFrE2V45A1reBF4k+ucg5v8OWNr
         6foVHcOc70Qj3EJZRuSSlh1K87s12zk/79wOXCD5SBX97vLWCW6Zv9WSWOnG6SyiEXz0
         ebRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Vy5HkXsUeiVT5tvBi6bh7Myxz6JGg1bF1CT6DCfajZ0=;
        b=PSIIqHfG4pj/1RoPynalxGnXV7PF/j65OTyBDu0dmrte91l1Nk/TwMzpkBK4HI9UUj
         qQR/gV9XmQCow5iacHmXaU6tR7Pr+/0tH4DpdVO2Bl6FL/ZziqSnobDBk2N8+62OPNP5
         grN0z5JJMwRNov8S666rG5Vsbgi3pPeUPi3DSqE/7PjPRDkkC+Bf0qlAAhSEq6vj6dyp
         1mF7BPf8aR7cjgWptVB6wcGtbg+f/iQyAupb3erWZ57KUp/y45nwW28NFRuDPa4vWzgA
         SXRicpWsaLZWVAMQKg2N/EBeTzp+Vwdc0cBHb5i6zEugw53E+Z1GR5LTY3ToRbxYWNTm
         JxlQ==
X-Gm-Message-State: ACrzQf2dlXxJUALGgmlNfUp18fUzT3TmReiCreBjjoogmJqWavtlmqEQ
	dXhjcvJTCo96XNImJQF3skWY5mAPAmbCOoYgzbnz9Kwjv9o=
X-Google-Smtp-Source: AMsMyM5MThh53AsyY8ShtTOPNs5ZBv3X1bEo0u5Y6HDgf8sqXDisW4/HOfdfOaOvhboRJZMwbDwurTnaE0htRIIbL4o=
X-Received: by 2002:a4a:94ea:0:b0:448:97a1:64ff with SMTP id
 l39-20020a4a94ea000000b0044897a164ffmr7080482ooi.63.1663614319484; Mon, 19
 Sep 2022 12:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com>
 <4379585e-42e4-53d9-8ca4-bf5b8ff3c95d@linux.intel.com> <Yyf9uIzwbb6O2E7o@black.fi.intel.com>
 <YygjnTyX+wNzIt5k@black.fi.intel.com> <YyiANMVWGc4Bvpj9@black.fi.intel.com>
In-Reply-To: <YyiANMVWGc4Bvpj9@black.fi.intel.com>
From: George Hilliard <thirtythreeforty@gmail.com>
Date: Mon, 19 Sep 2022 14:05:08 -0500
Message-ID: <CACmrr9joJi5v2DOu4AAX3tyWDxM5LV+bviRZHeesdp37b+8gRQ@mail.gmail.com>
Subject: Re: 5.19.9 regression: DMAR error on i7-8650U
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>, 
	Stefan Richter <stefanr@s5r6.in-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 19, 2022 at 9:43 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Baolu,
>
> On Mon, Sep 19, 2022 at 11:09:02AM +0300, Mika Westerberg wrote:
> > Here's bugzilla report that looks to have similar symptoms:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=216497
>
> The reporters of the above bugzilla bisected this down to:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.19.y&id=9516acba29e322202674d18f4dc383879f7813a5

I can confirm that reverting 9516acba29e322202674d18f4dc383879f7813a5
fixes the problem for me as well.

Cheers,
George
