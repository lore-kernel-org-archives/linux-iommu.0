Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39407100B3
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692312523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXs83oe+jiUngsGC+iU+QF+/YIyq3LUwh3cj5wAqVM8=;
	b=WQ6tGa0G+uoNZRYGeDwcLIOe/+xUIaVTEH9E1s5mRuPaRpiYlbbGBPRCoxPl8mqLrEcTO8
	1azzhbY0wG867yx3G6oIVxyt9epIgue5tXQ8DKsatBQDGToZR4M8AB/+zpka6Fa1dKafVd
	043uLv1H4zlploOvy5bA4xRcC0UFAYU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-n-K1vhsbM4y4DXJFyqSLtQ-1; Thu, 17 Aug 2023 18:48:39 -0400
X-MC-Unique: n-K1vhsbM4y4DXJFyqSLtQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1b728bfb372so266471fac.2
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 15:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312519; x=1692917319;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXs83oe+jiUngsGC+iU+QF+/YIyq3LUwh3cj5wAqVM8=;
        b=j8iflhH+9gFKU0PMAG8Md29d8lOzYmRtjrZNU5zEqBdi4TJzn5L06SfQBWTL530sYS
         mESFPDZNeKm1+7vsZv/dxycnIsTEZaWF2MG0WIB6hkfHXcivnY+dMl8j0N5IxnxQ2pwq
         6iBJtPm7GhsgkFJZPgkZgnrCCXn1RDrost5pP9i9Z6SSms8j3OVX+Th3rs7EcGzpgj/W
         Kez+DWbx1S4HE7ri/b3JukfPnP1mC/41hhuLvU3YX1ceUdbJj7y8AU+s9gs1q/bBpQMq
         U/ycPVgxznOrX3wHHsX1inrX6PW9uX8dolXhO8wP+vUm7HUoHaIaD8+Mi60bwl+FYZ7d
         bwNw==
X-Gm-Message-State: AOJu0YzVNJc6o641sSPx38l5C8lU7gXNOUhwuBMhMH4VQ0Ezq8z8gsnT
	Ni0TdF8/nwp4uZShozQH5C/2xQt7U4RAaw/tlVwW6wQwEweUyhg7Hs5tl38z1UBLN/Zs74aDC3A
	PaqdwdApiZOYK1aw=
X-Received: by 2002:a05:6870:c6a8:b0:1bf:ce5b:436 with SMTP id cv40-20020a056870c6a800b001bfce5b0436mr1043388oab.58.1692312518926;
        Thu, 17 Aug 2023 15:48:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgQU++51ftwhQ+Snud+8ZeqO8TZK2RxDc98dX0vPi5MbvU8WbZ3C+GYYuWCEGXKJRiM1igZQ==
X-Received: by 2002:a05:6870:c6a8:b0:1bf:ce5b:436 with SMTP id cv40-20020a056870c6a800b001bfce5b0436mr1043371oab.58.1692312518692;
        Thu, 17 Aug 2023 15:48:38 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id n7-20020a4a4007000000b0055516447257sm224025ooa.29.2023.08.17.15.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:48:38 -0700 (PDT)
Date: Thu, 17 Aug 2023 16:48:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: liulongfang <liulongfang@huawei.com>
Cc: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v13 0/4] add debugfs to migration driver
Message-ID: <20230817164835.5c219dc0.alex.williamson@redhat.com>
In-Reply-To: <20230816094205.37389-1-liulongfang@huawei.com>
References: <20230816094205.37389-1-liulongfang@huawei.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Aug 2023 17:42:01 +0800
liulongfang <liulongfang@huawei.com> wrote:

> Add a debugfs function to the migration driver in VFIO to provide
> a step-by-step test function for the migration driver.
> 
> When the execution of live migration fails, the user can view the
> status and data during the migration process separately from the
> source and the destination, which is convenient for users to analyze
> and locate problems.
> 
> Changes v12 -> v13
> 	Solve the problem of open and close competition to debugfs.

Hi,

I'm not sure if the new To: list is a mistake or if this is an appeal
to a different set of maintainers for a more favorable response than
previous postings[1], but kvm@vger.kernel.org remains the list for this
driver, which is under the perview of vfio [adding the correct list and
co-maintainer].

I believe there is still a concern whether this is a valid and
worthwhile debugfs interface.  It has been suggested that much of what
this provides could be done through userspace drivers to exercise the
migration interfaces and/or userspace debugging techniques to examine
the device migration data.  I haven't seen a satisfactory conclusion
for these comments yet.

I think we have general consensus that the first couple patches are ok
and useful, exposing the migration state generically and supporting a
minor cleanup within the hisi_acc driver.  However, the new approach to
try to lock the device with igate is certainly not the correct (igate
is used for serializing interrupt configuration) and the proposed
hisi_acc specific debugfs interfaces themselves are not settled.
Thanks,

Alex

[1]https://lore.kernel.org/all/20230728072104.64834-1-liulongfang@huawei.com/

