Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A417D3
	for <iommu@lists.linux.dev>; Sat, 25 Feb 2023 00:50:26 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id da10so4116521edb.3
        for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 16:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rznQ2Ogm4D33TB32Lv+pmA0yIC9Of9RuAOzuizAtFv4=;
        b=Rr+6dYF3riKD9r0sRAOHImobEYlinle0qvRckkGJ549mYTdkcVZgg/0D09XCsiv5aq
         G8/EV4kPzZLAxDdirBmS8S8vDUGp72l//4wUpHrMtlF8UqO2PuWy6W5P+ycHUDqcMkkq
         gnY/oUveByG76GpK8/M1c+X5wIh2noGzGZWGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rznQ2Ogm4D33TB32Lv+pmA0yIC9Of9RuAOzuizAtFv4=;
        b=TZhxF8R2I6oqqFvcqdbFJjMPmFEEPmMf/geDaxWvCACiIBoTfp0w+596gkmsHX50eK
         lO4cHiA/7LD0MISNC315EssJ3IAUjFKudlBUzm87GMKsYM3+NGjXUWQzM1QpK1skRDle
         qdUsKaHt3nTlNUSEKqTo7DQKw131652g9zHRAaEUA1Rd9ypU9lfqmOHcjh8NwqpoHs6S
         7HpZqS8gHzWAyq4ukcmrICjzfQIj/l7s8WkSRwMUYsIrolvtx5DW1gJ/wTJtwwicga0K
         qmfTyGzUYxcLYHubuShDU81pXmaellBh2SDp/UysZfd6pP9SmFVOREbYPeedSJu7HMpL
         4Eew==
X-Gm-Message-State: AO0yUKX1wn+0kpJzoDeQYwnLIY+Nv7v0ILLzYKl1QP0K8yIXKPGIUOF/
	YS8iH/NwYR4zrinnp5RobkELJUa9ZLmxF+9POLhLXA==
X-Google-Smtp-Source: AK7set90G2h44Uto85rXRO4tGGX8wwI5FNNvpRnyRQ+t9Iw3hKElzDN1Pn18S4+lwxGO8LyTB4zMBA==
X-Received: by 2002:a17:906:1757:b0:8af:3519:ea1 with SMTP id d23-20020a170906175700b008af35190ea1mr27463317eje.57.1677286224462;
        Fri, 24 Feb 2023 16:50:24 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b008b1815e30e3sm193540eju.117.2023.02.24.16.50.23
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 16:50:23 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id cy6so4064537edb.5
        for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 16:50:23 -0800 (PST)
X-Received: by 2002:a17:906:8508:b0:8d0:2c55:1aa with SMTP id
 i8-20020a170906850800b008d02c5501aamr9236553ejx.0.1677286223336; Fri, 24 Feb
 2023 16:50:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Y/Tlx8j3i17n5bzL@nvidia.com> <CAHk-=wiy2XRdvxchyuVYJJ618sAcGiPPam14z8yAW+kyCzgPmA@mail.gmail.com>
 <Y/lQIwcha1DFq2om@nvidia.com>
In-Reply-To: <Y/lQIwcha1DFq2om@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Feb 2023 16:50:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjM+p5K_MkM6COZou-u3S=6p1U4UsBHCaKximm5tT-Arg@mail.gmail.com>
Message-ID: <CAHk-=wjM+p5K_MkM6COZou-u3S=6p1U4UsBHCaKximm5tT-Arg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 24, 2023 at 4:02 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Do you like this sort of explanation in the email or the tag?

Either works, I really don't have a strong preference. Some people do
one, others do the other. And some people (like Rafael) do both - with
the summary list in the tag (and thus also as part of the pull
request), but an overview at the top of the email.

> Honestly, after 5 years (wow time flies) of sending PRs for rdma I'm
> still a bit unclear on the best way to write the tag message.

Heh. Probably because there isn't any "one correct" way. Whatever
works best for you.

The thing I personally care about is just that there _is_ an
explanation, and that it makes sense in the context of a human reader
who looks at the merge later.

So no automatically generated stuff that you could just get with some
git command anyway, but an actual overview.

And I'll edit things to make sense in a commit message anyway, so I'll
remove language like "This pull request contains.." because that
doesn't make sense once it's just a merge commit and no longer is a
pull request.

So I'll generally edit that kind of laniage down to "This contains.."
instead or something like that.

I also try to *generally* make the merge commit messages look roughly
the same, so that when people use wildly different whitespace (tabs vs
spaces) or use different bullet points - "-" vs "o" vs "*" etc) I
generally try to make those kinds of things also be at least
*somewhat* consistent.

And for that, it can certainly make my life easier if you look at what
merge messages look like, and don't try to make your pull request
message wildly different. But it's really not a big deal - I do that
kind of reformatting as part of simply reading the message, so it's
all fine.

Finally - remember that the merge message is for humans reading it
later, and not everybody necessarily knows the TLA's that may be
obvious to you as a maintainer of that subsystem. So try to make it
somewhat legible to a general (kernel developer) public.

And then if I feel like the message doesn't cover all of the changes,
I'll prod you, like I did in this case.

               Linus
