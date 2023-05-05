Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7C7E
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 01:43:35 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-24e16918323so898520a91.2
        for <iommu@lists.linux.dev>; Thu, 04 May 2023 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683251015; x=1685843015;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7hypnUIygICP+cjWknZimHYa1WmNJLmE2RPntTriZE=;
        b=SRSJR08bxAHAMdoZW4MZSe7iK6mrvIUWXj+xImkjInDeC+BKT5rulIeJRpprEA2A/P
         2wR4vDTEY/NcegpyBO388QGVn2G8aPEfOqdRijuytR9ctglQYCNn0SxDqGCGopDqqSXo
         hfW1BrVWN7aLwmkQjg9Vv+Tp0SFiGAK5EPSCjILMU2AHJqn8YB3qQm+FD1ZoLeQxImCB
         5V+YFmLL1Zs79Wm3ey664ZAd32AgVN8nXQQnXHNM889C0okh23bmeP5qaqOwv5wr/Vo9
         zDPRyCTYFG0G6WXU5KpHLb3XUMOXw4NjQHDNmXaZB0BALFk/ywV9inewGSuuLCDq2tQH
         erqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683251015; x=1685843015;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7hypnUIygICP+cjWknZimHYa1WmNJLmE2RPntTriZE=;
        b=EKRwQE9PbuL1mToK6XYqgsJB3nF+8UbUhxWzvL89u+dI6n4hN5hPG2U4ZajExOWNef
         mLOMAY135xyzcfxC5Cz7eJJzUOItoowhZmtpeQLwrpskAl7dF7NBs3Ja1VdlQidZYL+6
         IBqp4hiEZFCNSYjSDT72L99eIx+AaeH7Hrl4b4yMQi/a1e1oBNNkynrHoNmik3L/6tDh
         jvl9Bsyq83OcZC8zjskJut0IHgQ75YazgQH7RDe5Keg06YwhwxF+z61a4Pzt/P6Jl/DU
         8EyicfNpb1Q1P0SZGqeC1Y2Aaz6kHWxMmURSVpVuaewtOFwr0oV5/tsfIcL4WTYklbD6
         4DAA==
X-Gm-Message-State: AC+VfDzX3mfywMYEJk6cXuH/b8utusHjddKuq0C9zLr0LKywfkwLrBOl
	zgp8trPETv1W1ENgwcb8nKSQaUzYkEiFfkIgC+RQ1C7KqIVDvsVUM4MavMaS
X-Google-Smtp-Source: ACHHUZ4nn6CR7WvpwK2l3gX182OnFajAMv+Tvqu7NWUIZsz4N5QzlPEFmq4YJyzU6CckTRIsxWKcgbDLhrRwAXYlJiI=
X-Received: by 2002:a17:90b:380e:b0:249:748b:a232 with SMTP id
 mq14-20020a17090b380e00b00249748ba232mr3836196pjb.25.1683251014942; Thu, 04
 May 2023 18:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 4 May 2023 18:43:24 -0700
Message-ID: <CAMC_AXUHD=-zRxL-AogoDQTSz31SfmQ7u_eX3J5PVbXy4P86GA@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To: Jon Pan-Doh <pandoh@google.com>
Cc: Sudheer Dantuluri <dantuluris@google.com>, Gary Zibrat <gzibrat@google.com>, iommu@lists.linux.dev, 
	joro@8bytes.org, linux-kernel@vger.kernel.org, namit@vmware.com, 
	robin.murphy@arm.com, 
	"Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>, will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Cc'ing stable@vger.kernel.org per Nadav's suggestion.
