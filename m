Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260417CB
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 00:40:06 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bc7e65ea44so33170425ad.1
        for <iommu@lists.linux.dev>; Mon, 14 Aug 2023 17:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692060006; x=1692664806;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fMH5NUxHJYKatAlHbaGz3MMvlMMEAIyijBcdg08U7I=;
        b=O60H9O6duSSWPxF9+cT5wCCX/xo1hb8xou6gNN2DLR7KaHrWBG6be/XWHXfIDDc5Vj
         SN/2RnNQgFkt1SZcMwpkBJvg2M/1uwPghQg3SY9oMfCN1eL5esGOLuT+HJ/6tpYb8c1h
         6k71lDJSKco/flRnsoruqrdkrpFaMH3MTGBN1iti9E1BoeV9UZJCkmedsrU4c+bHdz9S
         NZciqQ+U3Nf+FRToptOpb9jaQ8Mnz1DKpImdGoNJK1MLgyOL6fmMXsmBhWoin/vsHIYl
         zpPhtMdQEOkmHJtCrV4Q5xDGdhjHMu0kTBAf3n0NS79xpv+vdmIUJyRAj5Y/C0hMCyCM
         Xccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692060006; x=1692664806;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5fMH5NUxHJYKatAlHbaGz3MMvlMMEAIyijBcdg08U7I=;
        b=JvQHE00DXMjfG4VQbzUjMXT63Ll9hAq9Y/nTnW0xf+2t1SbAzYS84PUliUboUNqZom
         KNmfnsA/MmBqoBUe0k043IzirjTdWcpksZrE9v6yPzuYoltENrqN2yQEbOORpbSnWmMC
         SSvbCqbMoUHbAoroPFsmCaA01ODkpS03E8E6rcaE2S1M9FuKzQ+yW0PnnzXeqKvBbB4u
         eu8PwT1xPXk485snsYaKr5JhNNQwTv4wp1DZpfHKychl/F0s3Pv+y/3benNZ//AZVR+m
         KR2XI9+arl7ML119ozoE13pQtDaj/HXwohLkfnnHwzGV2rPw4JI24RTS0BwMILW9ig5T
         lWjw==
X-Gm-Message-State: AOJu0Yy/0S3quw4CBbxZXGpZoqr2duZ3057hC6z7/mLFJ/2qJJk8e4bN
	AOlksdNU4x1MHtykH6QwFwU=
X-Google-Smtp-Source: AGHT+IEEB6lflMWlhdrUmo5oN54WcibS/WJd1F77YfnrV1RIzKdDuvX9wskpOnr5e3Bi5m8h8e9QTA==
X-Received: by 2002:a17:903:32d0:b0:1b8:8682:62fb with SMTP id i16-20020a17090332d000b001b8868262fbmr740355plr.4.1692060005978;
        Mon, 14 Aug 2023 17:40:05 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ab8200b001bbbc655ca1sm10023858plr.219.2023.08.14.17.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 17:40:05 -0700 (PDT)
Message-ID: <e75b57d9-9093-0a22-d53d-e510fd422279@gmail.com>
Date: Tue, 15 Aug 2023 07:39:58 +0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Ilya Maximets <i.maximets@ovn.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Joseph Vance Reilly <Joseph.Reilly@uga.edu>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux BPF <bpf@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux.dev>
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: AF-XDP program in multi-process/multi-threaded configuration
 IO_PAGEFAULT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Hello,
> 
> I am currently doing research on AF_XDP and I encountered a bug that is present in multi-process and multi-threaded configurations of AF_XDP programs. I believe there is a race condition that causes an IO_PAGEFAULT and the entire OS to crash when it is encountered. This bug can be reproduced using Suricata release 7.0.0-rc1, or another program where multiple user space processes each with an AF_XDP socket are created.
> 
> I have attached some sample code that has should be able to reproduce the bug. This code creates n processes where n is the number of RX queues specified by the user. In my experience the higher the number of processes/RX queues used, the higher the likelihood of triggering the crash. 
> 
> To change the number of RX queues, use Ethtool to set the number of combined RX queues, this may vary depending on network card:
> sudo ethtool -L <interface> combined <number of RX queues>
> 
> Compile the code using make and run the code as such:
> sudo -E ./xdp_main.o <interface> <number of child processes> consec
> 
> To get the crash to show up, lots of traffic needs to be sent to the network interface. In our experimental setup, a machine using Pktgen is sending traffic to the machine running the AF_XDP code at max line rate. Using Pktgen, vary the IP/MAC addresses of each packet to make sure the packets are somewhat evenly distributed across each RX queue. This may help with reproducing the bug. Also be sure the interface is set to promiscuous mode.
> 
> While sending traffic at max line rate, send a SIGINT to the AF_XDP program receiving the traffic to terminate the program. Sometimes an IO_PAGEFAULT will occur. This is more common than not. Also attached are some screen shots of the terminal and of the output our server gives.
> 
> The bug occurs because each process has the same STDIN file descriptor and as a result each child process gets the same SIGINT signal at the same time causing them all to terminate at once. During this, I believe a race condition is reached where the AF_XDP program is still receiving packets and is trying to write them to a UMEM that no longer exists. The order of operations to cause this would be:
> 1. XDP program looks up AF_XDP socket in XSKS_MAP 
> 2. User space program deletes UMEM and/or AF_XDP socket 
> 3. XDP program tries to write packet to UMEM
> 
> This can also be reproduced with Suricata as stated earlier with a similar traffic load as described for my personal program.
> 
> If more clarification is needed, please reach out to me. I would also like to know if this is an intended design or the cause of this bug. I look forward to hearing from you!

See Bugzilla for the full thread and attached reproducer code.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217712

-- 
An old man doll... just what I always wanted! - Clara
