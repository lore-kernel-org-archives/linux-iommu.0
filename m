Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB037F
	for <iommu@lists.linux.dev>; Mon, 26 Jun 2023 02:34:35 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so346531cf.0
        for <iommu@lists.linux.dev>; Sun, 25 Jun 2023 19:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687746874; x=1690338874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVihiOZ7lPOY7hWnryBrA+/oD8EUpfcein9lW0Ydcsk=;
        b=GhmUcgPljQdG2384d7n4zPhgPF1A8jlJj/FoVpS3RNM7mhOMGGIPZxppBsMavyMNWi
         HRqepk1SgLdE5JPLTmheF5+H8SovFdX6IpPjbQEGc6us6sAChK+55yvCG14vmmkXoWPn
         pPJ1ABIlsLv3Zgr8aAnRWCtZs0I2sk+yAKUxvYiy7KQLO5LHexdpm97nHa1jJOoAaVWN
         poZl9GcVW6o6syEFLGKR6Bp+F1q7SV3NZB0xArX1BCRMvm9cwZaV1p25JLZYYUVhriqA
         IPIK0SbR02E0xlDNoPoWCrODaTO8r9CDCxeABmG3/xLp0r174r1lRlqksMwtfsv7gUbB
         ldUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687746874; x=1690338874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVihiOZ7lPOY7hWnryBrA+/oD8EUpfcein9lW0Ydcsk=;
        b=BYGttYBYPzmznQrt0rD8LkROhVRgVdDziLDBErxJ0gaPCNricHBB04pNZw5p/m6+Ih
         +yJC1lpCxnRQ8pBIiQmLxLnX/CfNxAvSNE0RX8YaN1mEwyeTnIrn5wQyNdJvYkz+o73L
         cwpY4sj9r4c4ewSUV9DmejtrmE7keBXBJDl5bZ1cy5+nZqPgKlPmwKNtuBQkSWBSK08l
         q0m/7EWKGg5NBPzxB1+JvnOR8S37dSw6kWD50isnvf0qyQIf/j/doJGlHxF7mCVM2WWg
         yWPuK3INJ6JoKbs+hyaVAZHi0Ls3M6h/h8xr8cNcR+zSqlKRIEJ6iQGqpnnrby84O2QM
         c9KA==
X-Gm-Message-State: AC+VfDwJjHqRRdgBOD7gdd+cWXZU51isn3GhiQtCKTehLNCECQfvO5lh
	EYygTYCZ045aUu5cTkD47D2AxtvvfizhgRP2Jjtm7Q==
X-Google-Smtp-Source: ACHHUZ7KqHud5NmiMLt8ROhheSgT/+vI3VHyqtcHQSYmrTg3qxQ9b3kP3R6Lk5LWQ/Dwf1B2MxFkjILp3mELs2c9mGQ=
X-Received: by 2002:a05:622a:8d:b0:3f9:6930:1308 with SMTP id
 o13-20020a05622a008d00b003f969301308mr267696qtw.13.1687746874453; Sun, 25 Jun
 2023 19:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-10-mshavit@google.com>
 <ZJToAfeKg8FF1sZL@Asurada-Nvidia>
In-Reply-To: <ZJToAfeKg8FF1sZL@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 26 Jun 2023 10:33:58 +0800
Message-ID: <CAKHBV266J1S6EMMjNCRMPhSXCKnqU7-H=rhi5iMbV4D9rH7WgQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Implement set_dev_pasid
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Would you please elaborate a bit more for the use case of
allowing that?

In short; to support devices that use SSID to isolate different
(device) contexts. Those contexts (and the memory available to them)
is partially managed by the device's Kernel driver.

> And which test configuration do you cover
using smmute? Would you mind sharing your test commands?

I used the setup suggested by Jean in
https://lore.kernel.org/all/20230511195928.GA288490@myrica/ , with the
following commands:
>>>
# Basic test
./smmute;
./smmute -u mmap;

# Test invalid access to not-mapped address
./smmute -u mmap -f drv;

# Test invalid access after unmap
./smmute -u mmap -f write -d;

# Check smmu_mn released when killed
mount -t tracefs nodev /sys/kernel/tracing;
echo 1 > /sys/kernel/tracing/events/iommu/enable;
echo 1 > /sys/kernel/tracing/events/smmu/enable;
./smmute -u mmap -k bind;
cat /sys/kernel/tracing/trace;
<<<

This only covers existing SVA functionality. To test the functionality
introduced by this patch, I used a device capable of generating DMA
transactions w/ SSID and a test driver with following tests:
1. Successful dma Read/Write to buffer mapped on domain attached with pasid
2. Unsuccessful dma Read/Write to same buffer after domain detached
from pasid, or after buffer unmapped from domain
3. Variations of the above with a domain attached to multiple pasids

I've been considering migrating those tests to the smmute driver if
that would be valuable.



On Fri, Jun 23, 2023 at 8:32=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> Hi Michael,
>
> On Wed, Jun 21, 2023 at 02:37:21PM +0800, Michael Shavit wrote:
> >
> > This change enables the use of the iommu_attach_dev_pasid API for
> > UNMANAGED domains. The primary use-case is to allow in-kernel users of
> > the iommu API to manage domains with PASID. This change also allows for
> > future support of pasid in the DMA api.
>
> Would you please elaborate a bit more for the use case of
> allowing that? And which test configuration do you cover
> using smmute? Would you mind sharing your test commands?
>
> I have run a sanity with this series using an SVA domain
> with a real master. It seems to be fine.
>
> Thanks
> Nicolin
