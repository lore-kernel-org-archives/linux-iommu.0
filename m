Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF58817
	for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 13:37:48 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id u18so11503885eda.9
        for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 05:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s5w2zE/944m+g5V/bVTV7gQUFsx9I9RhF9qMrL1AVKU=;
        b=ZXPrlu+3zNj/q9voGn5Syh1d19df7JfB636Er7w4octj+XVnK8wPGwNi4Izfjz5C7B
         0KehT2/hZ0znsNfxE+zM4TxxNWcxE74lpcV9Ibwikt1GfWnvxvJ2NbeVdNd9ZDU0dlCX
         I24b8VTFuPxw06lOcGbNR/izgoJu5H0AoKsEvdEBfaWinDYyPlxFBAsN5XAlpokbLAyU
         O9XdU7ENZshK5J0HwzJLKnWzdz/wiXnxoZRo/WOoWIWZsQNx+LuXMOsepWCv3yEbTGcM
         O6cHIoTtBlScmRYbQweafWjnwezQZzOkaHYHHRBgzat4suZnwed/MwUAQw7mA+ODvA14
         ZvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5w2zE/944m+g5V/bVTV7gQUFsx9I9RhF9qMrL1AVKU=;
        b=cFMmVwAsCGnwRo0r1QDr44gKykpZYuSpLFaDmHhKApgOvS72g8Sqxbe4LjrA1Xltfj
         MaAHnkNgnSYNIRj8umTKfV6pcB5wyq/ho2B/PWc6UAwy00T1ZpGp478THyM2aO9DUx+f
         xFtm7lvu67A89XYGQ6bRnAx8yNkJgb6BEGzzfSfL44CTyMUZOHlckCb3ukybVtN3KJ+U
         nFyIv6MzEPE89I+0aIguMLMMhqDXY2dSrVJN41ebwQq66T8CKcmtp1UilAzncN+z6EdQ
         NryoHNeB6TCbwmt2tVs6LTW2r4Gmr0x86+nrxS5UDyVDOuB56FkGOjYfWxlH0h209Hcs
         5CCg==
X-Gm-Message-State: AFqh2koptDYBdhkGrZdLKfBqV/LYe+OMSEml/N8BUWCOF6JF3MzFqhbu
	yleyS7p9pF3KYbnbZ9BOpGd4z4Zp3JHdkErcHYg=
X-Google-Smtp-Source: AMrXdXvWErugVRrVIpWDdxw+hsLc2tiLuCIRz/I7TOIG7FubPLTl5MEiGzoskAAxPNvGwEMKvkAl9IWbJ2vi4QQHeNY=
X-Received: by 2002:a50:fd8c:0:b0:484:9b8:4318 with SMTP id
 o12-20020a50fd8c000000b0048409b84318mr270521edt.115.1671975466540; Sun, 25
 Dec 2022 05:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <D41A3A42-2412-4722-9090-01565058E525@gmail.com> <6531c0eb-5ca7-9026-a8b7-eb4442629d0d@linux.intel.com>
In-Reply-To: <6531c0eb-5ca7-9026-a8b7-eb4442629d0d@linux.intel.com>
From: Zeno Davatz <zdavatz@gmail.com>
Date: Sun, 25 Dec 2022 14:37:35 +0100
Message-ID: <CAOkhzLWJzYoE-1b02ZLra=1FF7WjLYznf_PwMEAQWB0NGJsJhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI device reference count leak in
 has_external pci()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: wangxiongfeng2@huawei.com, dwmw2@infradead.org, iommu@lists.linux.dev, 
	joro@8bytes.org, jroedel@suse.de, robin.murphy@arm.com, will@kernel.org, 
	yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Dear Baolu

On Sun, Dec 25, 2022 at 2:16 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/12/25 20:11, Zeno Davatz wrote:
> > Hi
> >
> > I am getting this hang with kernel 6.1. See attachment.
> >
> > Is this related to your patch?
> >
> > Kernel 6.1 does not boot for me. Kernel 6.0 was fine.
>
> It seems unlikely.
>
> Have you located the patch through the bisect tool? Or does it boot well
> if you revert this patch?

I did not bisect the patch. All I currently know is that version 5.5
and version 6.0 of the Kernel booted fine for me.

I test every Kernel release and normally the boot process goes flawless.

The patch I am referring to is also mentioned by Linus in the Kernel
log, AFAICT tell the only PCI patch.

https://lkml.org/lkml/2022/12/11/206

Best
Zeno
