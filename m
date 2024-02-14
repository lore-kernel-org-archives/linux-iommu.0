Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AF7C084
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930887; cv=none; b=sLF0pVL2AxWewTnqfBhyGMG6RYNY6Ikbfgm5mwZyNHa2z52ybwuK2PEvWvLrU5RNgb78U7Nyklwig22+YvHHSWCDp7WnzNrmnKwhrNNQnzCHY9g/8NTbe51ns6JhlNRWH/m7HsYJCAiyGdUWfr5kpBXQjjxFy5/XKKnDfpETKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930887; c=relaxed/simple;
	bh=8ou5WjqaFbf0d6dlT4/+7co77L0bUTMJQFMyMq7YuMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkqlfGeoE06wt7B/BKPr/K9BGQicJ3vxA4wrFKWlTANFyfrl6ax/1eFYCsjSO74o5DIfN1T70AK6/UCkEMt1d1akx/0w9BKBf7JPsn1FXECQQ3UXFgK76AeqA8+kxCj5DF+wwum9Nt4FYnGLRyfawkaTb/QAKMRd6IlP0mUOD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuHC4aPc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuHC4aPc"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed179f0faso777678276.1
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 09:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707930885; x=1708535685; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ou5WjqaFbf0d6dlT4/+7co77L0bUTMJQFMyMq7YuMo=;
        b=iuHC4aPcMZMfAv2pXteo0iMpoKy5Ksjzx7Ky9Kd7e8RX9/gplOP8ZAZO0qX0U4aJlI
         EQHXkwf054G/Mlla2qVJTnuClyk+OTO4ccuHwyut6/Kvk0Wjw5uNZAjUI/FcYQ9c84Cj
         U2ukVq5yq08oAPrm7nWxGh1Uqm/PdaEuyYS0GDv/4C+BOJbMZHbJ49dh1V0hBF92jfFn
         0lZrCR6/XMhOZ0aMoO/wBpiC7uYsLTrufCYX4B+7fRHOz5Z8cBOuyfP98W+Xp4h19TXL
         2tYCWjZRsSnfjBImRcsELHbWVFKD72B7lzzh166iArwQ/Q4cUwj9DaP9VNoUsIe/2EwX
         ya8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707930885; x=1708535685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ou5WjqaFbf0d6dlT4/+7co77L0bUTMJQFMyMq7YuMo=;
        b=B1Dfkbksj9v6USGtwKrYfEt8/LE2VAUejtbzfKOnebofltEVfRBT88rtQTKsUEhJxs
         +vKoottS/lN2xPwIOdFyw8To/Qu/tG7i1YMnTZ+z7XOgcNEq+gFlgJbILqJ/jiPN1lf1
         +1dq8jRncxoFsx5AX2sL+GgyoATZHmA2Q/hYveXYupTP216iYzoh/aWA6ykm8WaB4mtW
         t0PDHu9NRgoh8cmazXc1sz23V9rKk91QLS1LOboYgxMLGwJ3Sds48DEkUYdLEi7RRQlV
         ig73zOXyku4Z/gLSPElxoOYiDu1XYa7l7Iuizz9aJmdFRktWwnL9q+MtxJ8RLCNbw+fm
         0R2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqRKxGsCpAs1Rzt5S3X+oPIYJZ4eI0X7b+SuULv4zIqaXhcwVMBtwJGapilJxKd1twoZ5qtGHRp1L+4drTICarMUbsSxo=
X-Gm-Message-State: AOJu0YyEGRZE6HJm2PhRxik+VwvMmLbZe67XiOUPe2Lg8BxrVgn9hbH/
	+n3Cr9cVOi73rX77XCcEy40o1Ljvfz7MdPSpAHCq+uhhKSPNMTzD8eEUFXOhVlMqFuSkwp/6tOh
	8PHzKCd2rzCijNDeW6pE5tna8xwe1siFaYMtF
X-Google-Smtp-Source: AGHT+IEklcDkHwhJJTRfE00RVqD2YD9tPurIlvkQmweXW1ROZAgTvoBmd93LGr06RSN2meH7bqCAE1CDi8ShYu3HlN0=
X-Received: by 2002:a25:4b84:0:b0:dbe:d2ec:e31 with SMTP id
 y126-20020a254b84000000b00dbed2ec0e31mr1980533yba.27.1707930884496; Wed, 14
 Feb 2024 09:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240214062020.GA989328@cmpxchg.org>
 <ZczSSZOWMlqfvDg8@tiehlicka> <ifz44lao4dbvvpzt7zha3ho7xnddcdxgp4fkeacqleu5lo43bn@f3dbrmcuticz>
 <ZczkFH1dxUmx6TM3@tiehlicka> <udgv2gndh4leah734rfp7ydfy5dv65kbqutse6siaewizoooyw@pdd3tcji5yld>
 <Zczq02jdZa9L0VKj@tiehlicka>
In-Reply-To: <Zczq02jdZa9L0VKj@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 09:14:30 -0800
Message-ID: <CAJuCfpFR85w5_8sX0uLfi4SsVb8Yr6DDu=VTA25PB-3SgC=5UA@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Michal Hocko <mhocko@suse.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:31=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 14-02-24 11:17:20, Kent Overstreet wrote:
> [...]
> > You gotta stop with this this derailing garbage.
>
> It is always pleasure talking to you Kent, but let me give you advice
> (free of charge of course). Let Suren talk, chances for civilized
> and productive discussion are much higher!

Every time I wake up to a new drama... Sorry I won't follow up on this
one not to feed the fire.


>
> I do not have much more to add to the discussion. My point stays, find a
> support of the MM community if you want to proceed with this work.
> --
> Michal Hocko
> SUSE Labs
