Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FD17C8
	for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 18:34:37 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-79492b8f4bbso1492651241.2
        for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689014076; x=1691606076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUAAl/JRibyURI8yLiQyKNMl3UrxYtFAVgDBPiZZxSg=;
        b=UYdx7lhZzY8M1QbkhaKAOzyy8/B9Esjii23aMR4RmX0L3BZZ35NxnWQvPbHAl5GKyW
         0JPM/5O8Ui+hGZ7DLZJ6XPdwxsRMYaViqPraVHspJS7jeQ7F0f3Z3/EYITTao2HIzXmM
         YPpfVG+rcbc9K90TJVmZ/NUWmkWoCKbyrx7NvT7Tx+rxer433xHStiar6RT3E33PVTQ6
         nLKbytlDU0qapWfpeLJ9eTiRE4HYNCKza2lHVQheEdlqIihC0K++99RhhJ9RqcrpTUxm
         VEPmka+R94Bg1d/+t3DzcEyF5qRv+leI2QOVaIKnGbDffVAGEE7a9UT9QFOhfnEyqPul
         KXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014076; x=1691606076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUAAl/JRibyURI8yLiQyKNMl3UrxYtFAVgDBPiZZxSg=;
        b=bulqYhEC94a2odZqNy9UKv1r8Jorg09EvScj2uFwpELS1fgtRMxhOv369N4pQJ9DTC
         /qB0amPlOUXp6tOjLhUF+fa3nAG/Ilss0LcnpukKQrrpOW5t3/cvbxmWZ3kiI7CUbqMQ
         X9SHfydDrglJLdczY74VAsZTIudwqQ16v8euJ+AacVHFiaZ6VklYMoqJbW7jooj4Fp5x
         cza0mdjAwofzWvZeC9YedZBx0kNImeH91DjVijT+XYj27t6N9IcVxRdEeVl8ew2CQAmV
         sQ+G1CECSfgn2QxXMmcBsrpNV95qgIfRt2ARVSYn5Z6mpkt4fanE9O5OJGXR0CU1x+Wb
         XNhQ==
X-Gm-Message-State: ABy/qLZ/KkqE/iCvnntu9NysnVWU6r3lb9TVWLnT7nLSenVk0uhDDoVv
	9DofOhKqHtFUNwauQ/PNQT6S0w==
X-Google-Smtp-Source: APBJJlFRwyBO0JL6E5OOIG3LFBD1+eXnRL673S95ZH2Rvx1xHhBMK1oXyQB+TH++8kznHjbeRAqo4A==
X-Received: by 2002:a67:fb43:0:b0:443:5bec:a2fd with SMTP id e3-20020a67fb43000000b004435beca2fdmr5929407vsr.18.1689014076125;
        Mon, 10 Jul 2023 11:34:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id s9-20020a0ca609000000b0063596878aaasm120384qva.18.2023.07.10.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:34:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qIviV-0004hG-0K;
	Mon, 10 Jul 2023 15:34:35 -0300
Date: Mon, 10 Jul 2023 15:34:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, nikhilnd@google.com,
	mshavit@google.com, iommu@lists.linux.dev, svarbanov@suse.de
Subject: Re: [PATCH] iommu: Expose an API to set identity domain
Message-ID: <ZKxPO/yrozheHqWz@ziepe.ca>
References: <20230707104857.348353-1-praan@google.com>
 <af4166f9-7b86-6c12-a8f8-ee0398743dd6@arm.com>
 <CAN6iL-Qu97hFbpOEPPtcVcWo_+=zjFy5fjJU-UnAqnY=ebFptw@mail.gmail.com>
 <CAN6iL-QWa=DNmfGDJHeOncZMktFyQ3LpNGiRu1Aa4cyQofdTnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN6iL-QWa=DNmfGDJHeOncZMktFyQ3LpNGiRu1Aa4cyQofdTnw@mail.gmail.com>

On Mon, Jul 10, 2023 at 02:33:10PM +0530, Pranjal Shrivastava wrote:

> Please let us know if there are any other ways/suggestions that allow
> us to install bypass for a single iommu group sitting in front of a
> platform device (This device is not removable/hot-pluggable and always
> sits on the system).

Maybe the FW should pass in this request that the device is trusted
and should get some performance DMA?

Jason
