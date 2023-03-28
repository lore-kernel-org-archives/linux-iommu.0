Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA527EA
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 02:58:07 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id z17so2634006vsf.4
        for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679972286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4pP9BpVMTE+iluP8oKlc8/OklZFONZeaXv/pNYUX8zA=;
        b=BkQPlX9r8ylc77QnOkqlsqx8+pZJMwwnvN5ByqVe2wM6/j/UQEArrknQRvOmA/Ead+
         Y0cERkfvLmYJLoq6CH3w1Gsl+0nzY9SNQMrUehaZTLquiINERhk9UZSTDd9deYh2JsRm
         pvxqtXjn9vgWzus9km/Vx43VqhPponR8+lFUMFzWVquTVRMgvS49G6xgw1Qf9lsZD/FG
         GjcLJoHfJpE08ips/PkaDW4Dipg2IE0lSZoMI774Sh6ZKJPwTJTUZQjGIsLtNTi3my5S
         qyPMGrf1MSKNG/VT4sdmJe00ugfoz/9OiNCNs+0iTl0oZh0o5HgiDZKdSu327TH//qMg
         3tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pP9BpVMTE+iluP8oKlc8/OklZFONZeaXv/pNYUX8zA=;
        b=MhwvTaAO6ZgkcK4mFO+M4TL4qScAi0kdzS8iX1vAhlbvkR3k2QJstYbKeHt4qPzsJr
         /ZOjkaMtH4PvnfKoTavZ+dKH5y9fBnlIh1kaU4xLBf80WHEBzrswAATTVMjMMAycHY/t
         bZj5javN7BbB5VXB8LELm77we5CkHS7fB5aivuWygirhP0SzSLKjCAYTE1uvIgYZ4ud6
         Pffk3Nnei+wmU28EKek4YMxQzAe0elH9JSBZLoSM6BhhzXj6qCzpbjALNfvA0hv2qWCM
         SDmiUppgnZJkEef5Y/rC9SYlkmVnra2DC2ogDDsVGWoSDoabovvw1tG19OeqF2FcFz3a
         Fbgg==
X-Gm-Message-State: AAQBX9eCsXLNTUcM25GYfXVLLjeve4d/cQOygeDjnMKcgDvMFVZxmXHP
	T7KeIIv5M9OrNzuFv+6Nx7rDxuA3l1nyoiZ48rQ=
X-Google-Smtp-Source: AKy350b+79ROympiGDP2VeTXwWhOmhIy5p1SEf5pzH4mGd5x+B301GAggWlZRpqYyenxpiHDz+6ygGd24hGgW6ZkjOY=
X-Received: by 2002:a67:cb82:0:b0:426:40e7:9148 with SMTP id
 h2-20020a67cb82000000b0042640e79148mr7343807vsl.6.1679972286136; Mon, 27 Mar
 2023 19:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
 <CAAfSe-tg7JwakdCcoLn3Ws_164HcsT21pWHkjjw0Qqwy8PWkhQ@mail.gmail.com> <ZCFNRfpUHbaGBvJb@8bytes.org>
In-Reply-To: <ZCFNRfpUHbaGBvJb@8bytes.org>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Tue, 28 Mar 2023 10:57:30 +0800
Message-ID: <CAAfSe-stDTabua1EMQBF-xp_=zyn6yzrRR9VFmzyQ6jwzufMfA@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Add reattaching support and fix memory leak issue
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Baolu Lu <baolu.lu@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Orson Zhai <orsonzhai@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Mar 2023 at 16:01, Joerg Roedel <joro@8bytes.org> wrote:
>
>
> Hi Chunyan,
>
> On Mon, Mar 27, 2023 at 10:47:18AM +0800, Chunyan Zhang wrote:
> > Not sure if you received this patchset, since I received a rejection
> > letter from mail.8bytes.org.
> >
> > If you didn't receive it, I can resend it with another email address.
> >
> > Otherwise, would you please pick up this series if there are no more comments.
>
> I didn't receive it, can you please send me the error message you got
> from my mail server?

Have sent it to you.

>
> Regards,
>
>         Joerg
