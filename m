Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2DC19930
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 18:18:35 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-259ac20bdeaso690577a91.1
        for <iommu@lists.linux.dev>; Thu, 08 Jun 2023 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686248315; x=1688840315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G33fAOzGILRWsNmJroydjyYALKnc1tltJG+VtowcH+M=;
        b=HHWasNyTwgL2aWumbEC7slXrM+f2l+7WY3V0DydtwT0zKFkTzTNj/fnHvph2d0vKaq
         CBD28giYV9UWT25SIyq7Qn1W8eDUc/ihjcZrN31uSpS4yuTYtSjHyMCior+dUbFD6j2s
         oOdEx83zvlqwtigyphY00kScP2EwWXJcWYgi/LimH2RnYt7k7Vs9YVBwAWuuTSx7922t
         kvNMgzT6pHlQB1ab/TlQ54fQp04V/v+TU08d3ZbyBq589GparLCjbEbVrketja4iuLHu
         lcpgrt8YUCIjmyFh9K/OUWjdv5oEtfHOKZ2BA/mEQAOoIO2HE45dXxdr4yIbB93dPwK4
         xXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686248315; x=1688840315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G33fAOzGILRWsNmJroydjyYALKnc1tltJG+VtowcH+M=;
        b=SraXtUvWfeagyyzuRamxAzaAhi4NzydNpEDSMDiq+hEHYdfIDvT0ZDEki7+c+kObzi
         K49Vk3LZXSnbivGc/c3HnyD7e+3p/BAiAPVqzlKefRtR9Wnk/D4/Coue9rPXQCTVKzpX
         SzRxAUkEI5DOpKZhOvbzNhfmrVTkfXOpyhWpQCoxh2tVKAAXyK+XXHd7YU5srH3KMztM
         VnP1V6oqM8RadnFGQ8pS8CS+VS0yYGNxKE1mDD5DrW6+K1R8jMm3OqZvZw6XrOLs2/Rd
         7f3lJdPYmcA7y1YVCJVHJneCXw6p7yK982kUd45bHCsgntZoYKDBHo+WJ2RtMhcBtRtO
         ziAQ==
X-Gm-Message-State: AC+VfDwckGt5+dSaDbtMk4yAhJz7KAFk0EBfH+Z9gBKDhz4E0R9f8R20
	7t9sPnCwR1JwDcnHBZlf2tNteICLOLhb8vncHds=
X-Google-Smtp-Source: ACHHUZ5dYfYYuoqJib7w/3fwjOwC0M+43Q793+OGi6p4E1R2dMfAYgNcVwWKIyx0zrbVoSgSAwleqJTrXp0UbJFQ8VU=
X-Received: by 2002:a17:90a:190d:b0:258:9995:91cb with SMTP id
 13-20020a17090a190d00b00258999591cbmr7531295pjg.49.1686248314991; Thu, 08 Jun
 2023 11:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com> <CAKgT0UcE5bUe7ChytSyUWEkyqdwnNR1k_rcfyykPPWJ=ZzsdRg@mail.gmail.com>
 <ZIH1/e2OcCuD7DEi@araj-dh-work> <CAKgT0UfTzExYZGNCEXCJaS7huWDxwoC3Z_2JCzJHAgr9Qyxmsg@mail.gmail.com>
 <7f1797b1-cd50-3c8d-59ff-8ce82ef1adb4@arm.com>
In-Reply-To: <7f1797b1-cd50-3c8d-59ff-8ce82ef1adb4@arm.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 8 Jun 2023 11:17:58 -0700
Message-ID: <CAKgT0UcdjjzavB65QVcuyPUJpaCXTG67y29JVbhQCEg0oo2+=A@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ashok Raj <ashok_raj@linux.intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, 
	iommu@lists.linux.dev, Ashok Raj <ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 8, 2023 at 11:02=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-06-08 18:10, Alexander Duyck wrote:

<...>

> > As a part of going down that rabbit hole I realized that the
> > reserved_regions seems to only list the MSI reservation. However after
> > digging a bit deeper it seems like there is code to reserve the memory
> > behind the root complex in the IOVA but it doesn't look like that is
> > visible anywhere and is the piece I am currently trying to sort out.
> > What I am working on is trying to figure out if the system that is
> > failing is actually reserving that memory region in the IOVA, or if
> > that is somehow not happening in our test setup.
>
> How old's the kernel? Before 5.11, intel-iommu wasn't hooked up to
> iommu-dma so didn't do quite the same thing - it only reserved whatever
> specific PCI memory resources existed at boot, rather than the whole
> window as iommu-dma does. Either way, ftrace on reserve_iova() (or just
> whack a print in there) should suffice to see what's happened.
>
> Robin.

We are working with a 5.12 kernel. I will do some digging. We may be
able to backport some fixes if needed.

Thanks,

- Alex
