Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA652D624
	for <iommu@lists.linux.dev>; Thu,  2 Nov 2023 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5b92b670f2aso347828a12.2
        for <iommu@lists.linux.dev>; Wed, 01 Nov 2023 20:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698895111; x=1699499911;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgjUtC+zu8DJl3nutAj39PQhgJ4yZrn+eZKN8r9ua1A=;
        b=Rl7zm30V/zonTLXmoUaC6oE4IjvPbCiU9Z8b8H5mpSpmogB6QUf5+McZXzipZWg/Do
         m0NOYfIDgnBLFSs4MipSI7QeR/PyQolXEVdLHWlvmfpZ++Ouq1dOyndm4N0JlKwy5Ul4
         5ycKx2jUqTrMbyQHuuA3tegsMSERaXUrthUicAXb01Razp10nwxkr+umAPtK9V5kmXeZ
         rShkmKxuIwomdW8TZ3k36o7qhcqyg7Svy0SNg+4KF1ig77CH61IWNXsjJ+7DdcBdilKD
         9KtBbVuL8jfrPy5aI2DaXVkDHJ/OHM5m+OeaIBnsYw5Hs5pCtMXJLZJphRe1RahHRuNE
         LP+g==
X-Gm-Message-State: AOJu0YyabvJTJkTRZlqXFxekVVka4PLpMlfqpwflGyEfKFL8HFTBiAMa
	ZDMHyJspX5dQ3pS0Zv1+4sA=
X-Google-Smtp-Source: AGHT+IGSCfdmNS3mXmmzwZOCcGimxAePh6gkFXbuO2VON++1MpnZsCB/34fPgfD7x43Ga95vlV7Ung==
X-Received: by 2002:a05:6a20:8f07:b0:181:6f00:2f73 with SMTP id b7-20020a056a208f0700b001816f002f73mr3080416pzk.3.1698895111246;
        Wed, 01 Nov 2023 20:18:31 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090ac90300b002800b26dbc1sm1442581pjt.32.2023.11.01.20.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 20:18:30 -0700 (PDT)
Date: Thu, 2 Nov 2023 12:18:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Linux KVM <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: The VFIO/IOMMU/PCI MC at LPC 2023 - See you soon!
Message-ID: <20231102031828.GA951173@rocinante>
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

Time truly flies!  The Linux Plumbers Conference starts in less than two
weeks. Hopefully, everyone is excited and has booked their attendance,
hotel rooms, flights, etc. :)

The conference agenda is now available at https://lpc.events/event/17/program,
and the complete schedule is at https://lpc.events/event/17/timetable.  All the
talks this year look amazing!

The VFIO/IOMMU/PCI micro-conference schedule has also been finalised and
can seen at https://lpc.events/event/17/sessions/172/#20231115.  We have
some fantastic speakers this year!

As before, please keep an eye on the  official conference website for
updates:

  https://lpc.events

Previous posts about the MC:

  - https://lore.kernel.org/linux-pci/20230821170936.GA749626@rocinante/
  - https://lore.kernel.org/linux-pci/20230711200916.GA699236@rocinante/
  - https://lore.kernel.org/linux-pci/20230620114325.GA1387614@rocinante/
  - https://lore.kernel.org/all/20230828140306.GA1457444@rocinante/

See you at the LPC 2023!

	Alex, Bjorn, Jörg, Lorenzo and Krzysztof
