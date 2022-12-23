Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF628476
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 14:10:35 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso3613819wmo.1
        for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 06:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrkt2ot3JD+yIheZ+BquTWsj1MB0Lqe52uu/xeIaxHg=;
        b=lI5KuU4mVDOuTLwNWArrptCjqXpIWpvYkJqZcUSoPRyFT6W4M47B3RCqI+yc6WzPK3
         iHSS90uRCXNm/yZbdZiKjCa6zg2SgmvHoLSvZUJFW301oXt9pvfmwisN7OJadA2/eNfy
         fzDXduLscMlHI+wfVAfriIWCvqJttAkBJOnCvsWYWnh385dju9iSzYhPRTBdeQji3FLl
         103VfMGahh2BPhGcfpAdVaj98rMvEZxYJVZ73t1Br3PIklOV7HSfkVppInIJazSgPiDM
         YVCXB+YEabWCftEiQ+lred5nSAPQF8S6Gwm0D7b5HcsAF3GoI0JAhF+q5gNOiKzm3Ukm
         hl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrkt2ot3JD+yIheZ+BquTWsj1MB0Lqe52uu/xeIaxHg=;
        b=mtUyooYWT/t153Liu6Pg1M9/UKo4MmCQJbl3c0bylgMW5O7Kq2Shijct2AcOig4dNc
         uqnBZ1+1Gk4sKfUsSLRjXmHI6BN/E+HQTvWkaumuFLbL3ZmhO/YUE75NQVtN8VllSYN6
         qQOU4Rzw2Bpj1nhN7gIrbWV9+qU9Xw0QQwxAvvfRMuVFU3j1OeHasipH/Pw1qorjq0Xm
         gE+FIPpPw7Ev2xUWDOGH9DezbnuEZZJOhoObDVgY1tLIKzQH3TtSPPd/ueEzOfpvHzyG
         Rx+dCuIJssobU3HxgP3cu6v4EeOhzZ2Q43AKGZk7Y2ObgF5zh3PwK/ed6QnfwmJdhyuS
         TvJQ==
X-Gm-Message-State: AFqh2koLbFh4nSV4ufKKEGQzVpD3Rs91U/0I7fFtnnO+zejuN2xAsO0g
	NAQ1M5NTvHhfoECeVmi/suo=
X-Google-Smtp-Source: AMrXdXv0AlqKbQolCmoSGD2HjnFBytfXNWEYlwxW+TP+9Wiv2DDOJjTjfmppDXDuI1BEVhEyUGnWzQ==
X-Received: by 2002:a05:600c:3844:b0:3d2:191d:2420 with SMTP id s4-20020a05600c384400b003d2191d2420mr7376196wmr.7.1671804633771;
        Fri, 23 Dec 2022 06:10:33 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:fdcf:52c5:7af:c812])
        by smtp.gmail.com with ESMTPSA id b2-20020adff242000000b0023662245d3csm3236111wrp.95.2022.12.23.06.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 06:10:32 -0800 (PST)
Date: Fri, 23 Dec 2022 14:10:32 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] vmalloc: reject vmap with VM_FLUSH_RESET_PERMS
Message-ID: <Y6W22EHKwrTztnJR@murray>
References: <20221223092703.61927-1-hch@lst.de>
 <20221223092703.61927-3-hch@lst.de>
 <Y6WB2ZGoL7FaFK+f@lucifer>
 <20221223140312.GA26826@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223140312.GA26826@lst.de>

On Fri, Dec 23, 2022 at 03:03:12PM +0100, Christoph Hellwig wrote:
> On Fri, Dec 23, 2022 at 10:24:25AM +0000, Lorenzo Stoakes wrote:
> > Might it be worth adding a specific vmap mask that explicitly indicates what
> > flags are permissible on vmap()? Then this could become e.g.:-
> >
> > 	if (WARN_ON_ONCE(flags & ~VM_VMAP_PERMITTED_MASK))
> > 		return NULL;
> >
> > And would be self-documenting as to why we are disallowing flags (i.e. they are
> > not part of the permitted vmap mask).
>
> That's probably a good idea.  It might need some time to audit
> for use of all the flags, though.

Perhaps leave that for a later patch (I could take a look as well), but in the
meantime might be worth adding a quick comment here indicating why the flag is
prohibited?
