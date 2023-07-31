Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C68BF0
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 12:11:36 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so35062935ad.1
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690805496; x=1691410296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mngAJlqs/COq099IalYaL6uLxy0J+hWHZlJdgQPkdY=;
        b=jOMu05AMNAhqk3x4LPUEa7P/ldvssa+2qXsgofyRbHdwB9e2lT8VUUxAEIU7j4b4EK
         LJtAOvSWXKuHuf5gHoO0yYiGJgH1BXXBOmqTx2P81ZXHOqMtocYuv4Msv1pZsENmPLJi
         H+bwpv5HwpllTbHEsxTKHElz8aWBzy+WoHPiyQMeDwENpm08IfnSV4Z5QHRpqYzT8hv1
         A1Wj03/XcfG8I7FsCY0ZqsgXQQgAMWECYEgpbQf4dN5dI5MZJ31/tvAmV3fj4iJIaj8T
         +3OvjfvrhsIApRK/C6JsJnKT8LbQoi34jN2IicsMsO6QGLUFqWm0P3uZHbPvL2C6Pkym
         J/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805496; x=1691410296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mngAJlqs/COq099IalYaL6uLxy0J+hWHZlJdgQPkdY=;
        b=e9nMxXZ/Phqnabutjv1u5EM8P3oNkAQXBKestW1DJW96mxLJVQczLkoxVPbBmJLr2Y
         dUq90eV5JA/2ETH5Fd7i5OvbZqei30yrjPOHY6tcQp2cN31YKqZwP646r3mG0YaMQylS
         eriYsCvXAzZWcJ4d5eftk5OTBDPQjBSKX2uHUs2eyFzv95MKtE19W8QsKwb5QBncX8cB
         z5a7OP3OTyo4NEXiKdXab5il+BoZrVdW83RKPKVWjGktPQ2Cdw/AFEQzCQA5b4zMB4vK
         wyk+5xF8bjWNTc+RJ0OJfpr2ekhk54mBqnLHZtcTvQtVyDZm7Ku5JcLqcORlvql5BtIr
         DBnA==
X-Gm-Message-State: ABy/qLa5FNWq0De9g1fuvnw1C4CRwMeKQLx11S7Y9lrhoHxQpQDcJW5J
	x91QUPuZZJ+r9RzgQFqDllBusYRsjKGjILWGHXY=
X-Google-Smtp-Source: APBJJlEU4lFm+jssDe8J570b2SWMOFj1imBUVDfRMwbxqvfUIKSji0+kD9Ji1RVfchVSZxuwIXUR+g==
X-Received: by 2002:a17:902:9045:b0:1bb:bbd4:aadf with SMTP id w5-20020a170902904500b001bbbbd4aadfmr7890370plz.61.1690805495884;
        Mon, 31 Jul 2023 05:11:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001b8062c1db3sm8440443plo.82.2023.07.31.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:11:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qQRkL-002Em0-Tc;
	Mon, 31 Jul 2023 09:11:33 -0300
Date: Mon, 31 Jul 2023 09:11:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 12/16] iommu/amd: Add support for different types of
 PPR handler
Message-ID: <ZMek9W9NoJAIxvqy@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-13-vasant.hegde@amd.com>
 <ZMPRN6Gz/dsbBnqe@ziepe.ca>
 <d231040e-c657-35aa-c6bb-9705c23afa82@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d231040e-c657-35aa-c6bb-9705c23afa82@amd.com>

On Mon, Jul 31, 2023 at 01:32:05PM +0530, Vasant Hegde wrote:

> >> +enum ppr_handlers {
> >> +	PPR_HANDLER_NONE,	/* No handler specified */
> >> +	PPR_HANDLER_V2API,	/* IOMMU v2 API ppr handler */
> >> +	PPR_HANDLER_IOPF,	/* IOPF ppr handler */
> > 
> > This constant is never used, move it to the patch that uses it.
> 
> Sure. I will move IOPF macro to later patch series.
> 
> > 
> > Why are you doing this? It would be much better to hook the GPU driver
> > into the standard API, what prevents that?
> 
> Because once we implement IOPF support we will have two different path. Hence
> adding variable to track PPR.

You should try very hard to avoid having two different paths.

Jason
