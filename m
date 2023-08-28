Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88A11C9D
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 14:03:46 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so2337126b3a.2
        for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 07:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693231426; x=1693836226;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IFFX7eMPzkrYgLogvMeXxd4wRFHGqYgPSd5LHSEAd0=;
        b=mAcRs/GNKQo8Lj5bO73kqTAr9XGi5kSEc+qWohAbPo5f66QbsqHfV1OHcAVYzQHDCe
         PgL4VvvWcvpNAcxkHykC8wnKKPopo8QpmAlNYEm30fkuM9g/OxHje+PT8ihmezGnK/1w
         rUxlG6OIUUqOOb9aNNUGHDgByMouvycv96JyCKq4cwvitiBlRp6c1nrdm4cJUj0vU4Cn
         xrNQbOICR6WB7ewj9Gdu2MluLBWTk5RrWh/Fv/TGa5n5zZGedwLC05ta5krbn4YZ7g2U
         FwKijM4+c4C4SRLHcIypxpeVlL0WuViwSaSQ0M30ELSETo/PQsfHCAFbLXFrhmabzjz6
         w6nw==
X-Gm-Message-State: AOJu0Yy3i7m1bEpBzynbVn0UqTK46H7IzHTZnuFpLBNz8gcuqQbOpaHj
	L+aJvUKntxivDoysuPEuodN3jqOt1Q0=
X-Google-Smtp-Source: AGHT+IFG0bmHs4i7t9hz71KPcBeXu4hA8Vhr56gE7lAMEg9SMsPZI/6SmPqC4OCIa+Bdv9HQWhKk7g==
X-Received: by 2002:a05:6a21:7890:b0:14c:d494:77d0 with SMTP id bf16-20020a056a21789000b0014cd49477d0mr9398763pzc.26.1693231425284;
        Mon, 28 Aug 2023 07:03:45 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b0064d57ecaa1dsm6648444pfh.28.2023.08.28.07.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:03:26 -0700 (PDT)
Date: Mon, 28 Aug 2023 23:03:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Linux IOMMU <iommu@lists.linux.dev>, Linux KVM <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: The VFIO/IOMMU/PCI MC at LPC 2023
Message-ID: <20230828140306.GA1457444@rocinante>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello everyone!

The Linux Plumbers Conference will start in about two months, so please
remember to book your attendance.

Also, keep an eye on the official conference website for updates:

  https://lpc.events

That said, on behalf of the PCI sub-system maintainers, I would like to
invite everyone to join our annual VFIO/IOMMU/PCI micro-conference (MC).

We are hoping to bring together, both in person and online, everyone
interested in the VFIO, IOMMU, and PCI space to talk about the latest
developments and challenges in these areas.

You can find the complete MC proposal at:

  https://drive.google.com/file/d/1U3_WvPzVeP7DcTSs5FN7jZ2EtTTzUSor

If you are interested in participating in our MC and have topics to propose
and would like to submit a talk for the MC, please follow the Call for
Papers (CfP) process at https://lpc.events/event/17/abstracts, selecting
the "VFIO/IOMMU/PCI MC" from the available tracks.  There is still time to
submit a proposal.

Join us!  We look forward to your presence and active participation at the
event.

Please get in touch with me directly if you need any assistance or have any
questions.

See you at the LPC 2023!

	Alex, Bjorn, Jörg, Lorenzo and Krzysztof
