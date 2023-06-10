Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89354110A
	for <iommu@lists.linux.dev>; Sat, 10 Jun 2023 20:50:36 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so32424081fa.3
        for <iommu@lists.linux.dev>; Sat, 10 Jun 2023 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686430234; x=1689022234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mBDbLFqvjAGNEyFKxiTNYtiar4TLQ4ztWPhRjrpVlw=;
        b=IxStg4faBgkuCF49oX7er3oOu4ux7zMQVyrq8i8kgl4kZIo62OvFLR9qndc0jZCWLH
         OUinExoCGzGp6/ds6+5krvK7DDsUU8A+0+SYgBze30HCQ/9a/7Fx7XlhF5liHtKXts5o
         HQaSRxkJqrEZCNbCxpHjm2oQ612/5pVw8HC6fNGuudLUtTJ5CR39IYXBcgpDnvQDr4fm
         hJVAsjh2Ar7q6Jx28IxIdorHew+xrtAHGBQbMFminLZ567EmFRRWRzqckcyq4F+/V7+f
         uxCm6vGhPSNedlwQzSqcZgk5d3QvGR3mLlq0znXX5L1R0NmwV5w7A5LaqZiY6rAYQq+S
         sEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686430234; x=1689022234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mBDbLFqvjAGNEyFKxiTNYtiar4TLQ4ztWPhRjrpVlw=;
        b=DWQHMcpmwgFCHdkDJA949VkFyzLeYlK0/cxY/TaLcAG1H7wJI2bO8NbkxoySO5ZCev
         eDX4b6P4MFpE9OR+FxSMAaal9gJuYZb7S9hUAYMFM3C/XRpU/Lb1WPb8ZGrojwhqX4ON
         cfZCAvoDZpqlT04AtiL+tKZKNMyNEUDhap9Q0ZK+QP4oDuYOhoQ0O3iUjTkMEWqKklz8
         H1yitFwOE8anHZkNNYgCYKUMlZgv2wVVsvBtIogfNDzdkR16HIhGZ1OPmSIs+blDWD1o
         SX29sw7+2sugNsBxIantywz7NYY2ke4hMz/EudZ7ozqsI6X/U1psuz0/dMm5/8AzdB6P
         S89g==
X-Gm-Message-State: AC+VfDxah91gqNiIA3ogV6YtjtmCclfV+9RBmYwldg7SEfyELqKtN4vB
	Kme6LTeMNoYR0M+STS6sDU0uNjzYnoQTn7du0cncXEUYs9U=
X-Google-Smtp-Source: ACHHUZ5FS5Bm/Exvz2rA3cba4GJPU2EfFhL5jebyIyTTaok6cIyW4kpL9X+j+rAE8cmOK76iA8WJkv9DFJI3Zxo8Cco=
X-Received: by 2002:a2e:804b:0:b0:2b0:489e:c457 with SMTP id
 p11-20020a2e804b000000b002b0489ec457mr812326ljg.39.1686430233983; Sat, 10 Jun
 2023 13:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAD7mqryC_JROVXY9eD--iigjCU9266+ufPvZO2BujhVfM7qYfw@mail.gmail.com>
 <f416c0dc-a82b-f608-4c6a-c2441b417bfb@linux.intel.com>
In-Reply-To: <f416c0dc-a82b-f608-4c6a-c2441b417bfb@linux.intel.com>
From: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>
Date: Sat, 10 Jun 2023 16:50:22 -0400
Message-ID: <CAD7mqrwR7RmUt5q22biJyTWx15HiOFDoBUuhOzf=EBuXxmghwQ@mail.gmail.com>
Subject: Re: IOMMU software bounce buffers and their overhead
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Thank you for the response and resources.
I was able to mark a device as external and untrusted by
editing the kernel source code which enabled SW bounce
buffers for that device.

Best regards,
Chathura
