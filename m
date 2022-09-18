Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780A637
	for <iommu@lists.linux.dev>; Sun, 18 Sep 2022 00:00:56 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id n83so10472272oif.11
        for <iommu@lists.linux.dev>; Sat, 17 Sep 2022 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:content-transfer-encoding:mime-version:subject
         :message-id:cc:to:from:date:from:to:cc:subject:date;
        bh=H8nIqSaMPs0y0jy4LZ0na6VHvPO1alb9pdk4FKTd5/0=;
        b=bVZ71qkMNvmsXjhNnIYaTdpiC8dzy8s7+W+WnKBgQV7dzEOYzRz6Y/M9BVoarhZNmF
         CFxKUvtgVKEKCBKNOfVjri5oVLXdoGx8ww7jhFGaHisfWcIBOt5uqnDXWc8JvSPIgzL7
         8dzdo3erd3dc9eCJntZVRDLjgbvGMi3qzdUkwzTf99ZJy3ms1n33kFIJDnjWRBKfbf88
         FFaOB9KMKM/kQtmA89iQvLC/aNzziA17XIJPQm9C5tb8YQvSBpyUVz/e9DhUsqQy4FZI
         QXWYHgp6wR1X9lAARvNOncMeafBArH6TahcjBTEv0ydqAeXdDHW5pUTCnrvqh7oqu2f3
         q1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:content-transfer-encoding:mime-version:subject
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=H8nIqSaMPs0y0jy4LZ0na6VHvPO1alb9pdk4FKTd5/0=;
        b=mlhROCryMWRtI1UluzIG939s0wQTRLQy1Fil+/eCw7nfbRe6gilx0lcWudcgYAWyol
         nX7L8wdEGbQVmbtY9LrE3NCPD4513ilpL14bjRR5/XHbTasTjmpEQdhueuPbeiw5jaZZ
         9rJINOIKyGPuyGlu5YunUkbB9YnWMkYZ2SnwqIpSQcKty/WZUa5/y3/q1He0oO+4EBaC
         8qecC1iO7e8UgDzdtxCBgPf+1rFxTWL0wxEwWHbA1I+zB36kEc3aLxEXkjwnB8cYNGic
         wo7EZGAbK+RDLNXviIWfXrx8J8Qn1EGzYu6QIt/DGcFlHiCIFiPL9vLrttw4TTW/xX7M
         2Mcw==
X-Gm-Message-State: ACgBeo3saEdifYlQn+rhcJDlzm35XE1vPHK1eAJcFFX0/vxcmmlrxt5V
	BKOIykhngSXhQL32Tu9K5vQ=
X-Google-Smtp-Source: AA6agR70l9PucnGfzSj+aPvTgsPZpffD06gRuViOe/9b2uVvVpQxWWoRlaOc8Dd46fRbRYO9qFGVog==
X-Received: by 2002:aca:909:0:b0:34f:ba63:eced with SMTP id 9-20020aca0909000000b0034fba63ecedmr9694253oij.270.1663459255557;
        Sat, 17 Sep 2022 17:00:55 -0700 (PDT)
Received: from bebop (2603-8080-2704-6601-b457-170a-9e05-cc6d.res6.spectrum.com. [2603:8080:2704:6601:b457:170a:9e05:cc6d])
        by smtp.gmail.com with ESMTPSA id cd15-20020a056830620f00b00638c25074afsm12037115otb.34.2022.09.17.17.00.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Sep 2022 17:00:55 -0700 (PDT)
Date: Sat, 17 Sep 2022 19:00:54 -0500
From: George Hilliard <thirtythreeforty@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: "=?utf-8?Q?iommu=40lists.linux.dev?=" <iommu@lists.linux.dev>, 
 "=?utf-8?Q?linux1394-devel=40lists.sourceforge.net?="
 <linux1394-devel@lists.sourceforge.net>, Stefan Richter
 <stefanr@s5r6.in-berlin.de>
Message-ID: <485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com>
Subject: 5.19.9 regression: DMAR error on i7-8650U
X-Mailer: Mailspring
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm experiencing a regression on 5.19.9 from 5.19.8. Not sure if you are
already aware of this, apologies if it's noise.  My hunch is that this
is an iommu problem since there were quite a few iommu changes in .9,
but I have also Cc'd Firewire maintainers on the chance that I'm wrong.

My Apple Thunderbolt to Firewire adapter has quit working on 5.19.9 on
my Thinkpad T480s (i7-8650U), with the following log message while
enumerating the device (reformatted for email):

    [  318.263546] thunderbolt 0-1: new device found, vendor=0x1 device=0x8004
    [  318.263559] thunderbolt 0-1: Apple, Inc. Thunderbolt to FireWire Adapter
    [  318.342416] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
    [  318.342428] pcieport 0000:05:01.0: pciehp: Slot(1): Link Up
    (snip)
    [  318.503177] pcieport 0000:08:00.0: enabling device (0000 -> 0003)
    [  318.504976] firewire_ohci 0000:09:00.0: enabling device (0000 -> 0002)
    [  318.562000] firewire_ohci 0000:09:00.0: added OHCI v1.10 device
                   as card 4, 8 IR + 8 IT contexts, quirks 0x0, physUB
    [  318.562109] DMAR: DRHD: handling fault status reg 2
    [  318.562114] DMAR: [INTR-REMAP] Request device [09:00.0] fault
                   index 0x8080 [fault reason 0x25] Blocked a
                   compatibility format interrupt request

The last two lines are the new error.

Happy to provide more details or experiment; this happens nearly every time.

George
