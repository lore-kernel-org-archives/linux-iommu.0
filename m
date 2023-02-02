Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75168F60
	for <iommu@lists.linux.dev>; Thu,  2 Feb 2023 19:39:33 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id d8so3006799ljq.9
        for <iommu@lists.linux.dev>; Thu, 02 Feb 2023 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JmnIaySd7zoAM6xF2ibXT8yo+UTOpvQnMVr9b5O/7+w=;
        b=ca1h9KkMFNsKgO7Ao0NeYlaifxp7NzGcaaakgNFyQLMxBSXDHTcSanf/uonLuKRR18
         lO7gVsm341hb9Nhg1BLsB8gPuvWRYHLOlq9HV87cUF6Vj8wjTPtsHShRpe/Vd30GyM78
         DjJAMh6ZqNcvDd+rLB79O+fNMlUiqjmmCA6so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmnIaySd7zoAM6xF2ibXT8yo+UTOpvQnMVr9b5O/7+w=;
        b=sz7zwYPMxbAb1JwtJjC1hPhv34ZRPLktay/JlH4SmdYO3drTHhoDbEwYSCJyppGxUP
         nZIQoBF1gdT2jo1MPWeEaktyOh0mTOm+kxw3hXSq056iXjW3zA4xHgyA2gAhMuvAP/sj
         3HvQ8JehetzbGrxA7bwfRL0wkoTOK+m61kokHAjatinjY3hpPwvejdzBkONaNFWI4eGV
         mKVk4wmYIuGMmY/0aD3DC96d1zt77zlveF9LKfOwwce00tZE4hPhW+Rnzfs/6UJQNnvB
         73GMuVUB+O8dUhEn02xECQ0Jda0m8+WZWJSv/Dg8OFeqynKLpwOPuSbjT3dago7CxSwy
         dnag==
X-Gm-Message-State: AO0yUKVHxXrbgavYfitrahEML7OB2rhIO3Qoc2UD9XhyqduakGRQYpYq
	/wHKxP0utcJi+gWxyOJLKMJrALUoqughdqw+bdw=
X-Google-Smtp-Source: AK7set+tnj5ZlneoVlE68Ayt2cjDwms1qCMYjc4qZtIJTKSQDW+TFktTXBF3OooLmL47zIHogMHoVA==
X-Received: by 2002:a05:651c:8c:b0:28e:3e6:f3f4 with SMTP id 12-20020a05651c008c00b0028e03e6f3f4mr1840313ljq.21.1675366771463;
        Thu, 02 Feb 2023 11:39:31 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651234c600b00492c663bba2sm25434lfr.124.2023.02.02.11.39.30
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:39:30 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id v17so4550517lfd.7
        for <iommu@lists.linux.dev>; Thu, 02 Feb 2023 11:39:30 -0800 (PST)
X-Received: by 2002:a17:906:f109:b0:882:e1b7:a90b with SMTP id
 gv9-20020a170906f10900b00882e1b7a90bmr2112186ejb.187.1675366759217; Thu, 02
 Feb 2023 11:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230202145030.223740842@infradead.org>
In-Reply-To: <20230202145030.223740842@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Feb 2023 11:39:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF6y7CwR1P5_73aK2f=x=RZjwgh3sgeO3Mczv4XcDc8g@mail.gmail.com>
Message-ID: <CAHk-=wiF6y7CwR1P5_73aK2f=x=RZjwgh3sgeO3Mczv4XcDc8g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Introduce cmpxchg128() -- aka. the demise of cmpxchg_double()
To: Peter Zijlstra <peterz@infradead.org>
Cc: corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com, 
	mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org, 
	tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, 
	Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz, roman.gushchin@linux.dev, 
	42.hyeyoo@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-s390@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 2, 2023 at 7:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>  - fixed up the inline asm to use 'u128 *' mem argument so the compiler knows
>    how wide the modification is.
>  - reworked the percpu thing to use union based type-punning instead of
>    _Generic() based casts.

Looks lovely to me. This removed all my concerns (except for the
testing one, but all the patches looked nice and clean to me, so
clearly it must be perfect).

                Linus
