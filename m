Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC22F50
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 09:32:00 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-40c72caec5cso373131cf.0
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692610319; x=1693215119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laAe1Bo4NZ8AdV8W9Bh3WsToh2Bjfo6A1xgGVoYjoyQ=;
        b=dLa7m7YOFXaI8f3LH4rmihbtsr0xg3WAuCXck0gHdLLzonLi1YVjZzMuNX+7sPul3v
         gSojDkMsPLSogLdEbUM6mySPFZTo7tXT8cWUxXiHJM18TI0HXs10W24ppFH4eywBoQ0P
         SjjvA3ak2E/K7OTROdIm789q+Hj60/+PZwxX479WbHalkuq7FfhUWWYDdXDgkqYIa+Cq
         IGfAuXNtJSpMseZUcI1g7EV9hmyv4X5DqBtA/QdTWMU0Zx/bDqPjei50o3dF87DSfPqB
         U/vqX4L71zson4Sjp52xAf8fD4z3DJHLzscqUpLgHRTMOQ+8HbJfPyBAOJaxB/n69CM8
         P/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692610319; x=1693215119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laAe1Bo4NZ8AdV8W9Bh3WsToh2Bjfo6A1xgGVoYjoyQ=;
        b=Gy8Nt1XMqIzk8c5FW81l4KHZjv16icUvs8bwxZiFqEnXdVQsoPB2anN6JS6B6RDlMv
         oq39J4MxN9NDz+/p3H8Cd9LpTptCGf7x1hEU1AbBU7VSNLdL+MzSucmEmRcSuW4BnkK4
         NL8LIv5Xv/raH+Vn1lg/mNR+S1SYrROJgW73MUB59cwcksglpYRmdCyMV9LowHmWVyp6
         BCHacsZtBVGdUFBcXptdJlf3Kf+h8KlxaDcUYP8QXwN2JB4iPxAiht27DfaexlBiJKO/
         I2xHrNtkTiOX9LcqUYa6LRD0Dug6kRTXkVeplq0MQyAcqwq2a5OKLXoIXMX9wvdOM89j
         R+uQ==
X-Gm-Message-State: AOJu0Yzpeva7sqoL1jmRr9yGh8YY09R9J0p+unyA1AtN6yKt+2BJBXEI
	UXvDmlYPJX5WznFsv6je/6WaYyx4f778GMIHQT7inA==
X-Google-Smtp-Source: AGHT+IGsyBh91ymEq6DEeNpzIVHw7+WcMyX8lYQffIO3qca7jbZOrPGYPHweVK6U14iNXO73ZrJVgVuQHp3pHi8oVcE=
X-Received: by 2002:a05:622a:1801:b0:3f0:af20:1a37 with SMTP id
 t1-20020a05622a180100b003f0af201a37mr510984qtc.15.1692610319419; Mon, 21 Aug
 2023 02:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com>
In-Reply-To: <ZN5pK03Drao/egeF@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 21 Aug 2023 17:31:23 +0800
Message-ID: <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com, 
	tina.zhang@intel.com, jean-philippe@linaro.org, robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 2:38=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrote:
> > Pick an ASID that is within the supported range of all SMMUs that the
> > domain is installed to.
> >
> > Signed-off-by: Michael Shavit <mshavit@google.com>
> > ---
>
> This seems like a pretty niche scenario, maybe we should just keep a
> global for the max ASID?
>
> Otherwise we need a code to change the ASID, even for non-SVA domains,
> when the domain is installed in different devices if the current ASID
> is over the instance max..

This RFC took the other easy way out for this problem by rejecting
attaching a domain if its currently assigned ASID/VMID
is out of range when attaching to a new SMMU. But I'm not sure
which of the two options is the right trade-off.
Especially if we move VMID to a global allocator (which I plan to add
for v2), setting a global maximum for VMID of 256 sounds small.
