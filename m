Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A41F9A99
	for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709585; cv=none; b=eD6n3kVhNB3CJES7OIu9bxOOEU4BXsKwB+D4P3jVn1a6IEgrjdVAYyvArM7rzM/7wXbssC6TSuetJ+s5Ssy2GzBCEdQ73zXqLsC5dkO8G97cEST1BXkRZM6rm7tpfFkUGkamQqkJMJeYiqzS8AwihVutEzUDLG1ZOMCxjxqnE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709585; c=relaxed/simple;
	bh=vBno7GuEDCM1/4IOivOOT2Cliqy5K1vujVJ/+0Z6i0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=glQK/EDHEd2BuH8BjRg+Dzb6otXXSZFcvsLI4+8n30UtyTg/TUUek8199rshOvC4p+teT1SqedGm5XCDO+3ReI7IYwddi3uqnEB6UEjACKYOXAu0U4g8GWN6nMF0aghpqKR+d1vA70JO/3okfJcQgUD8ruIyxfFS3er41ffZ/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A7651477;
	Wed, 27 Nov 2024 04:13:24 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 379343F66E;
	Wed, 27 Nov 2024 04:12:53 -0800 (PST)
Message-ID: <ee40c840-eba4-453f-9dee-5a2dc00492a9@arm.com>
Date: Wed, 27 Nov 2024 12:12:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gaW9t?=
 =?UTF-8?Q?mu=3A_Downgrade_print_level_for_iommu_group_information?=
To: "Li,Rongqing" <lirongqing@baidu.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20241126072339.25714-1-lirongqing@baidu.com>
 <84cb9155-4793-45f9-bb67-6926e103dc84@arm.com>
 <e790f039210f4bd78a015a6fa439c607@baidu.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <e790f039210f4bd78a015a6fa439c607@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2024 12:09 pm, Li,Rongqing wrote:
> 
>> On 26/11/2024 7:23 am, Li RongQing wrote:
>>> This per device log is becoming longer with more and more PCI devices
>>> in system, which slows down the boot process due to the serializing
>>> nature of printk().
>>>
>>> Downgrade dev_info() to dev_dbg() so it is still accessible for debug
>>> purposes.
>>
>> Previously discussed 4 and a half years ago:
>>
>> https://lore.kernel.org/linux-iommu/20200302154426.GC6540@8bytes.org/
>>
>> Also, given that the iommu_probe_device() path is inherently serialised anyway,
>> if logging a message from there significantly slows down your boot process, how
>> slow is your console device?
>>
> 
> 
> There are 482 in my machine, spends nearly about 3 seconds

OK, but how much of that is actually spent in printk? And given that 
those timings imply the machine is probably taking a minute or more to 
boot to a point of being useful, how much does 3 seconds really matter?

My test box is smaller and simpler, so already boots over 10x faster 
than that:

root@crazy-taxi:~# dmesg | grep 'init process'
[    4.379612] Run /init as init process

yet with one simple trick I can easily turn that into 100x faster:

root@crazy-taxi:~# dmesg | grep 'init process'
[    0.477168] Run /init as init process

That's the exact same kernel, merely rebooted with "loglevel=1". Putting 
732 lines into the log buffer is not slow in itself. What adds 4 seconds 
overall is echoing said log buffer to a 115200bps serial console. If you 
really care about boot time on your machine, the solution is not to take 
away useful information from everyone, it's to configure *your machine* 
to not bottleneck itself on emitting to a slow console device in the 
first place.

Thanks,
Robin.

> [   40.083614] DMAR: dmar1: Using Queued invalidation
> [   40.089008] DMAR: dmar0: Using Queued invalidation
> [   40.094402] DMAR: dmar19: Using Queued invalidation
> [   40.100816] pci 0000:79:00.4: Adding to iommu group 0
> [   40.106586] pci 0000:79:01.0: Adding to iommu group 1
> [   40.112346] pci 0000:79:02.0: Adding to iommu group 2
> [   40.118315] pci 0000:74:00.4: Adding to iommu group 3
> [   40.124074] pci 0000:74:01.0: Adding to iommu group 4
> [   40.129830] pci 0000:74:02.0: Adding to iommu group 5
> [   40.135788] pci 0000:6f:00.4: Adding to iommu group 6
> [   40.141550] pci 0000:6f:01.0: Adding to iommu group 7
> [   40.147313] pci 0000:6f:02.0: Adding to iommu group 8
> [   40.153268] pci 0000:6a:00.4: Adding to iommu group 9
> [   40.159037] pci 0000:6a:01.0: Adding to iommu group 10
> [   40.164898] pci 0000:6a:02.0: Adding to iommu group 11
> [   40.170956] pci 0000:57:00.4: Adding to iommu group 12
> [   40.176797] pci 0000:57:01.0: Adding to iommu group 13
> [   40.180021] Freeing initrd memory: 21192K
> [   40.182633] pci 0000:58:00.0: Adding to iommu group 14
> [   40.192922] pci 0000:59:00.0: Adding to iommu group 15
> [   40.198758] pci 0000:59:01.0: Adding to iommu group 16
> [   40.204592] pci 0000:59:02.0: Adding to iommu group 17
> [   40.210432] pci 0000:59:1f.0: Adding to iommu group 18
> [   40.216277] pci 0000:5a:00.0: Adding to iommu group 19
> [   40.222121] pci 0000:5b:00.0: Adding to iommu group 20
> [   40.227968] pci 0000:5c:00.0: Adding to iommu group 21
> [   40.233813] pci 0000:5d:00.0: Adding to iommu group 22
> [   40.239873] pci 0000:44:00.4: Adding to iommu group 23
> [   40.245711] pci 0000:44:01.0: Adding to iommu group 24
> [   40.251548] pci 0000:45:00.0: Adding to iommu group 25
> [   40.257385] pci 0000:46:00.0: Adding to iommu group 26
> [   40.263221] pci 0000:46:01.0: Adding to iommu group 27
> [   40.269058] pci 0000:46:02.0: Adding to iommu group 28
> [   40.274901] pci 0000:47:00.0: Adding to iommu group 29
> [   40.280733] pci 0000:48:00.0: Adding to iommu group 30
> [   40.286591] pci 0000:49:00.0: Adding to iommu group 31
> [   40.292657] pci 0000:31:00.4: Adding to iommu group 32
> [   40.298493] pci 0000:31:01.0: Adding to iommu group 33
> [   40.304337] pci 0000:32:00.0: Adding to iommu group 34
> [   40.310174] pci 0000:33:00.0: Adding to iommu group 35
> [   40.316011] pci 0000:33:01.0: Adding to iommu group 36
> [   40.321850] pci 0000:33:02.0: Adding to iommu group 37
> [   40.327697] pci 0000:34:00.0: Adding to iommu group 38
> [   40.333544] pci 0000:35:00.0: Adding to iommu group 39
> [   40.339390] pci 0000:36:00.0: Adding to iommu group 40
> [   40.345451] pci 0000:1e:00.4: Adding to iommu group 41
> [   40.351283] pci 0000:1e:01.0: Adding to iommu group 42
> [   40.357122] pci 0000:1f:00.0: Adding to iommu group 43
> [   40.362976] pci 0000:20:00.0: Adding to iommu group 44
> [   40.368807] pci 0000:20:01.0: Adding to iommu group 45
> [   40.374645] pci 0000:20:02.0: Adding to iommu group 46
> [   40.380487] pci 0000:20:1f.0: Adding to iommu group 47
> [   40.386340] pci 0000:21:00.0: Adding to iommu group 48
> [   40.392185] pci 0000:22:00.0: Adding to iommu group 49
> [   40.398042] pci 0000:23:00.0: Adding to iommu group 50
> [   40.403889] pci 0000:24:00.0: Adding to iommu group 51
> [   40.409956] pci 0000:0b:00.4: Adding to iommu group 52
> [   40.415795] pci 0000:0b:01.0: Adding to iommu group 53
> [   40.421662] pci 0000:0c:00.0: Adding to iommu group 54
> [   40.427516] pci 0000:0c:00.1: Adding to iommu group 55
> [   40.433664] pci 0000:f6:00.4: Adding to iommu group 56
> [   40.439540] pci 0000:f6:01.0: Adding to iommu group 57
> [   40.445414] pci 0000:f6:02.0: Adding to iommu group 58
> [   40.451486] pci 0000:f1:00.4: Adding to iommu group 59
> [   40.457360] pci 0000:f1:01.0: Adding to iommu group 60
> [   40.463236] pci 0000:f1:02.0: Adding to iommu group 61
> [   40.469295] pci 0000:ec:00.4: Adding to iommu group 62
> [   40.475174] pci 0000:ec:01.0: Adding to iommu group 63
> [   40.481049] pci 0000:ec:02.0: Adding to iommu group 64
> [   40.487103] pci 0000:e7:00.4: Adding to iommu group 65
> [   40.492974] pci 0000:e7:01.0: Adding to iommu group 66
> [   40.498847] pci 0000:e7:02.0: Adding to iommu group 67
> [   40.504904] pci 0000:80:00.4: Adding to iommu group 68
> [   40.510940] pci 0000:d3:00.4: Adding to iommu group 69
> [   40.516777] pci 0000:d3:01.0: Adding to iommu group 70
> [   40.522612] pci 0000:d4:00.0: Adding to iommu group 71
> [   40.528451] pci 0000:d5:00.0: Adding to iommu group 72
> [   40.534289] pci 0000:d5:01.0: Adding to iommu group 73
> [   40.540127] pci 0000:d5:02.0: Adding to iommu group 74
> [   40.545966] pci 0000:d5:1f.0: Adding to iommu group 75
> [   40.551819] pci 0000:d6:00.0: Adding to iommu group 76
> [   40.557671] pci 0000:d7:00.0: Adding to iommu group 77
> [   40.563521] pci 0000:d8:00.0: Adding to iommu group 78
> [   40.569374] pci 0000:d9:00.0: Adding to iommu group 79
> [   40.575448] pci 0000:bf:00.4: Adding to iommu group 80
> [   40.581286] pci 0000:bf:01.0: Adding to iommu group 81
> [   40.587138] pci 0000:c0:00.0: Adding to iommu group 82
> [   40.592976] pci 0000:c1:00.0: Adding to iommu group 83
> [   40.598813] pci 0000:c1:01.0: Adding to iommu group 84
> [   40.604648] pci 0000:c1:02.0: Adding to iommu group 85
> [   40.610498] pci 0000:c2:00.0: Adding to iommu group 86
> [   40.616351] pci 0000:c3:00.0: Adding to iommu group 87
> [   40.622213] pci 0000:c4:00.0: Adding to iommu group 88
> [   40.628279] pci 0000:ab:00.4: Adding to iommu group 89
> [   40.634118] pci 0000:ab:01.0: Adding to iommu group 90
> [   40.639963] pci 0000:ac:00.0: Adding to iommu group 91
> [   40.645803] pci 0000:ad:00.0: Adding to iommu group 92
> [   40.651640] pci 0000:ad:01.0: Adding to iommu group 93
> [   40.657480] pci 0000:ad:02.0: Adding to iommu group 94
> [   40.663334] pci 0000:ae:00.0: Adding to iommu group 95
> [   40.669186] pci 0000:af:00.0: Adding to iommu group 96
> [   40.675038] pci 0000:b0:00.0: Adding to iommu group 97
> [   40.681124] pci 0000:97:00.4: Adding to iommu group 98
> [   40.686964] pci 0000:97:01.0: Adding to iommu group 99
> [   40.692803] pci 0000:98:00.0: Adding to iommu group 100
> [   40.698743] pci 0000:99:00.0: Adding to iommu group 101
> [   40.704680] pci 0000:99:01.0: Adding to iommu group 102
> [   40.710618] pci 0000:99:02.0: Adding to iommu group 103
> [   40.716560] pci 0000:99:1f.0: Adding to iommu group 104
> [   40.722512] pci 0000:9a:00.0: Adding to iommu group 105
> [   40.728454] pci 0000:9b:00.0: Adding to iommu group 106
> [   40.734413] pci 0000:9c:00.0: Adding to iommu group 107
> [   40.740360] pci 0000:9d:00.0: Adding to iommu group 108
> [   40.746537] pci 0000:83:00.4: Adding to iommu group 109
> [   40.752557] pci 0000:00:00.0: Adding to iommu group 110
> [   40.758491] pci 0000:00:00.1: Adding to iommu group 111
> [   40.764431] pci 0000:00:00.2: Adding to iommu group 112
> [   40.770418] pci 0000:00:00.4: Adding to iommu group 113
> [   40.776353] pci 0000:00:10.0: Adding to iommu group 114
> [   40.782285] pci 0000:00:13.0: Adding to iommu group 115
> [   40.788322] pci 0000:00:14.0: Adding to iommu group 116
> [   40.794261] pci 0000:00:14.2: Adding to iommu group 116
> [   40.800201] pci 0000:00:14.4: Adding to iommu group 117
> [   40.806137] pci 0000:00:15.0: Adding to iommu group 118
> [   40.812219] pci 0000:00:16.0: Adding to iommu group 119
> [   40.818155] pci 0000:00:16.1: Adding to iommu group 119
> [   40.824091] pci 0000:00:16.4: Adding to iommu group 119
> [   40.830024] pci 0000:00:17.0: Adding to iommu group 120
> [   40.835959] pci 0000:00:18.0: Adding to iommu group 121
> [   40.841894] pci 0000:00:19.0: Adding to iommu group 122
> [   40.847975] pci 0000:00:1f.0: Adding to iommu group 123
> [   40.853950] pci 0000:00:1f.4: Adding to iommu group 123
> [   40.859884] pci 0000:00:1f.5: Adding to iommu group 123
> [   40.865770] pci 0000:01:00.0: Adding to iommu group 114
> [   40.871658] pci 0000:01:00.1: Adding to iommu group 114
> [   40.877600] pci 0000:02:00.0: Adding to iommu group 114
> [   40.883531] pci 0000:02:01.0: Adding to iommu group 114
> [   40.889484] pci 0000:02:02.0: Adding to iommu group 114
> [   40.895397] pci 0000:02:03.0: Adding to iommu group 114
> [   40.901371] pci 0000:03:00.0: Adding to iommu group 114
> [   40.907346] pci 0000:04:00.0: Adding to iommu group 114
> [   40.913320] pci 0000:05:00.0: Adding to iommu group 114
> [   40.919295] pci 0000:06:00.0: Adding to iommu group 114
> [   40.925165] pci 0000:07:00.0: Adding to iommu group 115
> [   40.931047] pci 0000:08:00.0: Adding to iommu group 115
> [   40.936985] pci 0000:0b:00.0: Adding to iommu group 124
> [   40.942923] pci 0000:0b:00.1: Adding to iommu group 125
> [   40.948860] pci 0000:0b:00.2: Adding to iommu group 126
> [   40.954796] pci 0000:1e:00.0: Adding to iommu group 127
> [   40.960732] pci 0000:1e:00.1: Adding to iommu group 128
> [   40.966672] pci 0000:1e:00.2: Adding to iommu group 129
> [   40.972609] pci 0000:31:00.0: Adding to iommu group 130
> [   40.978551] pci 0000:31:00.1: Adding to iommu group 131
> [   40.984487] pci 0000:31:00.2: Adding to iommu group 132
> [   40.990426] pci 0000:44:00.0: Adding to iommu group 133
> [   40.996364] pci 0000:44:00.1: Adding to iommu group 134
> [   41.002299] pci 0000:44:00.2: Adding to iommu group 135
> [   41.008239] pci 0000:57:00.0: Adding to iommu group 136
> [   41.014177] pci 0000:57:00.1: Adding to iommu group 137
> [   41.020114] pci 0000:57:00.2: Adding to iommu group 138
> [   41.026055] pci 0000:6a:00.0: Adding to iommu group 139
> [   41.031992] pci 0000:6a:00.1: Adding to iommu group 140
> [   41.037927] pci 0000:6a:00.2: Adding to iommu group 141
> [   41.043852] pci 0000:6a:03.0: Adding to iommu group 142
> [   41.049778] pci 0000:6a:03.1: Adding to iommu group 143
> [   41.055708] pci 0000:6f:00.0: Adding to iommu group 144
> [   41.061643] pci 0000:6f:00.1: Adding to iommu group 145
> [   41.067578] pci 0000:6f:00.2: Adding to iommu group 146
> [   41.073522] pci 0000:74:00.0: Adding to iommu group 147
> [   41.079451] pci 0000:74:00.1: Adding to iommu group 148
> [   41.085387] pci 0000:74:00.2: Adding to iommu group 149
> [   41.091321] pci 0000:79:00.0: Adding to iommu group 150
> [   41.097247] pci 0000:79:00.1: Adding to iommu group 151
> [   41.103184] pci 0000:79:00.2: Adding to iommu group 152
> [   41.109119] pci 0000:7e:00.0: Adding to iommu group 153
> [   41.115049] pci 0000:7e:00.1: Adding to iommu group 154
> [   41.120989] pci 0000:7e:00.2: Adding to iommu group 155
> [   41.126924] pci 0000:7e:00.3: Adding to iommu group 156
> [   41.132851] pci 0000:7e:00.5: Adding to iommu group 157
> [   41.138787] pci 0000:7e:01.0: Adding to iommu group 158
> [   41.144723] pci 0000:7e:01.1: Adding to iommu group 159
> [   41.150676] pci 0000:7e:01.2: Adding to iommu group 160
> [   41.156612] pci 0000:7e:02.0: Adding to iommu group 161
> [   41.162546] pci 0000:7e:02.1: Adding to iommu group 162
> [   41.168481] pci 0000:7e:02.2: Adding to iommu group 163
> [   41.174420] pci 0000:7e:03.0: Adding to iommu group 164
> [   41.180357] pci 0000:7e:03.1: Adding to iommu group 165
> [   41.186291] pci 0000:7e:03.2: Adding to iommu group 166
> [   41.192228] pci 0000:7e:05.0: Adding to iommu group 167
> [   41.198167] pci 0000:7e:05.1: Adding to iommu group 168
> [   41.204104] pci 0000:7e:05.2: Adding to iommu group 169
> [   41.210040] pci 0000:7e:06.0: Adding to iommu group 170
> [   41.215981] pci 0000:7e:06.1: Adding to iommu group 171
> [   41.221920] pci 0000:7e:06.2: Adding to iommu group 172
> [   41.227856] pci 0000:7e:07.0: Adding to iommu group 173
> [   41.233793] pci 0000:7e:07.1: Adding to iommu group 174
> [   41.239729] pci 0000:7e:07.2: Adding to iommu group 175
> [   41.245665] pci 0000:7e:08.0: Adding to iommu group 176
> [   41.251606] pci 0000:7e:08.1: Adding to iommu group 177
> [   41.257544] pci 0000:7e:08.2: Adding to iommu group 178
> [   41.263487] pci 0000:7e:0c.0: Adding to iommu group 179
> [   41.269413] pci 0000:7e:0d.0: Adding to iommu group 180
> [   41.275352] pci 0000:7e:0e.0: Adding to iommu group 181
> [   41.281287] pci 0000:7e:0f.0: Adding to iommu group 182
> [   41.287220] pci 0000:7e:1a.0: Adding to iommu group 183
> [   41.293154] pci 0000:7e:1b.0: Adding to iommu group 184
> [   41.299092] pci 0000:7e:1c.0: Adding to iommu group 185
> [   41.305026] pci 0000:7e:1d.0: Adding to iommu group 186
> [   41.310968] pci 0000:7f:00.0: Adding to iommu group 187
> [   41.316903] pci 0000:7f:00.1: Adding to iommu group 188
> [   41.322843] pci 0000:7f:00.2: Adding to iommu group 189
> [   41.328767] pci 0000:7f:00.3: Adding to iommu group 190
> [   41.334695] pci 0000:7f:00.4: Adding to iommu group 191
> [   41.340629] pci 0000:7f:00.5: Adding to iommu group 192
> [   41.346564] pci 0000:7f:00.6: Adding to iommu group 193
> [   41.352500] pci 0000:7f:00.7: Adding to iommu group 194
> [   41.358443] pci 0000:7f:01.0: Adding to iommu group 195
> [   41.364379] pci 0000:7f:01.1: Adding to iommu group 196
> [   41.370314] pci 0000:7f:01.2: Adding to iommu group 197
> [   41.376252] pci 0000:7f:01.3: Adding to iommu group 198
> [   41.382187] pci 0000:7f:01.4: Adding to iommu group 199
> [   41.388122] pci 0000:7f:01.5: Adding to iommu group 200
> [   41.394048] pci 0000:7f:01.6: Adding to iommu group 201
> [   41.399985] pci 0000:7f:01.7: Adding to iommu group 202
> [   41.405926] pci 0000:7f:02.0: Adding to iommu group 203
> [   41.411861] pci 0000:7f:02.1: Adding to iommu group 204
> [   41.417798] pci 0000:7f:02.2: Adding to iommu group 205
> [   41.423731] pci 0000:7f:02.3: Adding to iommu group 206
> [   41.429669] pci 0000:7f:02.4: Adding to iommu group 207
> [   41.435605] pci 0000:7f:02.5: Adding to iommu group 208
> [   41.441542] pci 0000:7f:02.6: Adding to iommu group 209
> [   41.447478] pci 0000:7f:02.7: Adding to iommu group 210
> [   41.453417] pci 0000:7f:03.0: Adding to iommu group 211
> [   41.459350] pci 0000:7f:03.1: Adding to iommu group 212
> [   41.465289] pci 0000:7f:03.2: Adding to iommu group 213
> [   41.471226] pci 0000:7f:03.3: Adding to iommu group 214
> [   41.477160] pci 0000:7f:03.4: Adding to iommu group 215
> [   41.483085] pci 0000:7f:03.5: Adding to iommu group 216
> [   41.489021] pci 0000:7f:03.6: Adding to iommu group 217
> [   41.494957] pci 0000:7f:03.7: Adding to iommu group 218
> [   41.500900] pci 0000:7f:04.0: Adding to iommu group 219
> [   41.506833] pci 0000:7f:04.1: Adding to iommu group 220
> [   41.512768] pci 0000:7f:04.2: Adding to iommu group 221
> [   41.518701] pci 0000:7f:04.3: Adding to iommu group 222
> [   41.524634] pci 0000:7f:04.4: Adding to iommu group 223
> [   41.530585] pci 0000:7f:04.5: Adding to iommu group 224
> [   41.536522] pci 0000:7f:04.6: Adding to iommu group 225
> [   41.542455] pci 0000:7f:04.7: Adding to iommu group 226
> [   41.548395] pci 0000:7f:05.0: Adding to iommu group 227
> [   41.554330] pci 0000:7f:05.1: Adding to iommu group 228
> [   41.560259] pci 0000:7f:05.2: Adding to iommu group 229
> [   41.566192] pci 0000:7f:05.3: Adding to iommu group 230
> [   41.572129] pci 0000:7f:05.4: Adding to iommu group 231
> [   41.578061] pci 0000:7f:05.5: Adding to iommu group 232
> [   41.583999] pci 0000:7f:05.6: Adding to iommu group 233
> [   41.589932] pci 0000:7f:05.7: Adding to iommu group 234
> [   41.595876] pci 0000:7f:06.0: Adding to iommu group 235
> [   41.601809] pci 0000:7f:06.1: Adding to iommu group 236
> [   41.607746] pci 0000:7f:06.2: Adding to iommu group 237
> [   41.613682] pci 0000:7f:06.3: Adding to iommu group 238
> [   41.619615] pci 0000:7f:06.4: Adding to iommu group 239
> [   41.625550] pci 0000:7f:06.5: Adding to iommu group 240
> [   41.631481] pci 0000:7f:06.6: Adding to iommu group 241
> [   41.637418] pci 0000:7f:06.7: Adding to iommu group 242
> [   41.643359] pci 0000:7f:0a.0: Adding to iommu group 243
> [   41.649294] pci 0000:7f:0a.1: Adding to iommu group 244
> [   41.655233] pci 0000:7f:0a.2: Adding to iommu group 245
> [   41.661169] pci 0000:7f:0a.3: Adding to iommu group 246
> [   41.667103] pci 0000:7f:0a.4: Adding to iommu group 247
> [   41.673028] pci 0000:7f:0a.5: Adding to iommu group 248
> [   41.678964] pci 0000:7f:0a.6: Adding to iommu group 249
> [   41.684897] pci 0000:7f:0a.7: Adding to iommu group 250
> [   41.690837] pci 0000:7f:0b.0: Adding to iommu group 251
> [   41.696772] pci 0000:7f:0b.1: Adding to iommu group 252
> [   41.702709] pci 0000:7f:0b.2: Adding to iommu group 253
> [   41.708641] pci 0000:7f:0b.3: Adding to iommu group 254
> [   41.714576] pci 0000:7f:0b.4: Adding to iommu group 255
> [   41.720501] pci 0000:7f:0b.5: Adding to iommu group 256
> [   41.726442] pci 0000:7f:0b.6: Adding to iommu group 257
> [   41.732375] pci 0000:7f:0b.7: Adding to iommu group 258
> [   41.738313] pci 0000:7f:0c.0: Adding to iommu group 259
> [   41.744250] pci 0000:7f:0c.1: Adding to iommu group 260
> [   41.750185] pci 0000:7f:0c.2: Adding to iommu group 261
> [   41.756119] pci 0000:7f:0c.3: Adding to iommu group 262
> [   41.762046] pci 0000:7f:0c.4: Adding to iommu group 263
> [   41.767980] pci 0000:7f:0c.5: Adding to iommu group 264
> [   41.773912] pci 0000:7f:0c.6: Adding to iommu group 265
> [   41.779848] pci 0000:7f:0c.7: Adding to iommu group 266
> [   41.785789] pci 0000:7f:0d.0: Adding to iommu group 267
> [   41.791725] pci 0000:7f:0d.1: Adding to iommu group 268
> [   41.797658] pci 0000:7f:0d.2: Adding to iommu group 269
> [   41.803591] pci 0000:7f:0d.3: Adding to iommu group 270
> [   41.809525] pci 0000:7f:0d.4: Adding to iommu group 271
> [   41.815454] pci 0000:7f:0d.5: Adding to iommu group 272
> [   41.821394] pci 0000:7f:0d.6: Adding to iommu group 273
> [   41.827328] pci 0000:7f:0d.7: Adding to iommu group 274
> [   41.833270] pci 0000:7f:0e.0: Adding to iommu group 275
> [   41.839205] pci 0000:7f:0e.1: Adding to iommu group 276
> [   41.845142] pci 0000:7f:0e.2: Adding to iommu group 277
> [   41.851080] pci 0000:7f:0e.3: Adding to iommu group 278
> [   41.857017] pci 0000:7f:0e.4: Adding to iommu group 279
> [   41.862952] pci 0000:7f:0e.5: Adding to iommu group 280
> [   41.868889] pci 0000:7f:0e.6: Adding to iommu group 281
> [   41.874861] pci 0000:7f:0e.7: Adding to iommu group 282
> [   41.880805] pci 0000:7f:0f.0: Adding to iommu group 283
> [   41.886741] pci 0000:7f:0f.1: Adding to iommu group 284
> [   41.892675] pci 0000:7f:0f.2: Adding to iommu group 285
> [   41.898610] pci 0000:7f:0f.3: Adding to iommu group 286
> [   41.904536] pci 0000:7f:0f.4: Adding to iommu group 287
> [   41.910489] pci 0000:7f:0f.5: Adding to iommu group 288
> [   41.916422] pci 0000:7f:0f.6: Adding to iommu group 289
> [   41.922358] pci 0000:7f:0f.7: Adding to iommu group 290
> [   41.928301] pci 0000:7f:10.0: Adding to iommu group 291
> [   41.934226] pci 0000:7f:10.1: Adding to iommu group 292
> [   41.940159] pci 0000:7f:10.2: Adding to iommu group 293
> [   41.946093] pci 0000:7f:10.3: Adding to iommu group 294
> [   41.952027] pci 0000:7f:10.4: Adding to iommu group 295
> [   41.957955] pci 0000:7f:10.5: Adding to iommu group 296
> [   41.963890] pci 0000:7f:10.6: Adding to iommu group 297
> [   41.969817] pci 0000:7f:10.7: Adding to iommu group 298
> [   41.975761] pci 0000:7f:1d.0: Adding to iommu group 299
> [   41.981698] pci 0000:7f:1d.1: Adding to iommu group 300
> [   41.988022] pci 0000:7f:1e.0: Adding to iommu group 301
> [   41.993981] pci 0000:7f:1e.1: Adding to iommu group 301
> [   41.999939] pci 0000:7f:1e.2: Adding to iommu group 301
> [   42.005898] pci 0000:7f:1e.3: Adding to iommu group 301
> [   42.011856] pci 0000:7f:1e.4: Adding to iommu group 301
> [   42.017817] pci 0000:7f:1e.5: Adding to iommu group 301
> [   42.023779] pci 0000:7f:1e.6: Adding to iommu group 301
> [   42.029736] pci 0000:7f:1e.7: Adding to iommu group 301
> [   42.035672] pci 0000:83:00.0: Adding to iommu group 302
> [   42.041610] pci 0000:83:00.1: Adding to iommu group 303
> [   42.047556] pci 0000:83:00.2: Adding to iommu group 304
> [   42.053493] pci 0000:97:00.0: Adding to iommu group 305
> [   42.059434] pci 0000:97:00.1: Adding to iommu group 306
> [   42.065367] pci 0000:97:00.2: Adding to iommu group 307
> [   42.071309] pci 0000:ab:00.0: Adding to iommu group 308
> [   42.077242] pci 0000:ab:00.1: Adding to iommu group 309
> [   42.083175] pci 0000:ab:00.2: Adding to iommu group 310
> [   42.089111] pci 0000:bf:00.0: Adding to iommu group 311
> [   42.095053] pci 0000:bf:00.1: Adding to iommu group 312
> [   42.100985] pci 0000:bf:00.2: Adding to iommu group 313
> [   42.106922] pci 0000:d3:00.0: Adding to iommu group 314
> [   42.112858] pci 0000:d3:00.1: Adding to iommu group 315
> [   42.118794] pci 0000:d3:00.2: Adding to iommu group 316
> [   42.124734] pci 0000:80:00.0: Adding to iommu group 317
> [   42.130669] pci 0000:80:00.1: Adding to iommu group 318
> [   42.136604] pci 0000:80:00.2: Adding to iommu group 319
> [   42.142549] pci 0000:e7:00.0: Adding to iommu group 320
> [   42.148486] pci 0000:e7:00.1: Adding to iommu group 321
> [   42.154423] pci 0000:e7:00.2: Adding to iommu group 322
> [   42.160362] pci 0000:e7:03.0: Adding to iommu group 323
> [   42.166299] pci 0000:e7:03.1: Adding to iommu group 324
> [   42.172236] pci 0000:ec:00.0: Adding to iommu group 325
> [   42.178173] pci 0000:ec:00.1: Adding to iommu group 326
> [   42.184107] pci 0000:ec:00.2: Adding to iommu group 327
> [   42.190054] pci 0000:f1:00.0: Adding to iommu group 328
> [   42.195990] pci 0000:f1:00.1: Adding to iommu group 329
> [   42.201924] pci 0000:f1:00.2: Adding to iommu group 330
> [   42.207859] pci 0000:f6:00.0: Adding to iommu group 331
> [   42.213784] pci 0000:f6:00.1: Adding to iommu group 332
> [   42.219722] pci 0000:f6:00.2: Adding to iommu group 333
> [   42.225661] pci 0000:fe:00.0: Adding to iommu group 334
> [   42.231596] pci 0000:fe:00.1: Adding to iommu group 335
> [   42.237539] pci 0000:fe:00.2: Adding to iommu group 336
> [   42.243478] pci 0000:fe:00.3: Adding to iommu group 337
> [   42.249413] pci 0000:fe:00.5: Adding to iommu group 338
> [   42.255350] pci 0000:fe:01.0: Adding to iommu group 339
> [   42.261285] pci 0000:fe:01.1: Adding to iommu group 340
> [   42.267222] pci 0000:fe:01.2: Adding to iommu group 341
> [   42.273159] pci 0000:fe:02.0: Adding to iommu group 342
> [   42.279096] pci 0000:fe:02.1: Adding to iommu group 343
> [   42.285037] pci 0000:fe:02.2: Adding to iommu group 344
> [   42.290970] pci 0000:fe:03.0: Adding to iommu group 345
> [   42.296904] pci 0000:fe:03.1: Adding to iommu group 346
> [   42.302838] pci 0000:fe:03.2: Adding to iommu group 347
> [   42.308773] pci 0000:fe:05.0: Adding to iommu group 348
> [   42.314707] pci 0000:fe:05.1: Adding to iommu group 349
> [   42.320644] pci 0000:fe:05.2: Adding to iommu group 350
> [   42.326578] pci 0000:fe:06.0: Adding to iommu group 351
> [   42.332535] pci 0000:fe:06.1: Adding to iommu group 352
> [   42.338472] pci 0000:fe:06.2: Adding to iommu group 353
> [   42.344407] pci 0000:fe:07.0: Adding to iommu group 354
> [   42.350332] pci 0000:fe:07.1: Adding to iommu group 355
> [   42.356265] pci 0000:fe:07.2: Adding to iommu group 356
> [   42.362200] pci 0000:fe:08.0: Adding to iommu group 357
> [   42.368135] pci 0000:fe:08.1: Adding to iommu group 358
> [   42.374071] pci 0000:fe:08.2: Adding to iommu group 359
> [   42.380017] pci 0000:fe:0c.0: Adding to iommu group 360
> [   42.385951] pci 0000:fe:0d.0: Adding to iommu group 361
> [   42.391875] pci 0000:fe:0e.0: Adding to iommu group 362
> [   42.397807] pci 0000:fe:0f.0: Adding to iommu group 363
> [   42.403744] pci 0000:fe:1a.0: Adding to iommu group 364
> [   42.409681] pci 0000:fe:1b.0: Adding to iommu group 365
> [   42.415616] pci 0000:fe:1c.0: Adding to iommu group 366
> [   42.421548] pci 0000:fe:1d.0: Adding to iommu group 367
> [   42.427490] pci 0000:ff:00.0: Adding to iommu group 368
> [   42.433428] pci 0000:ff:00.1: Adding to iommu group 369
> [   42.439363] pci 0000:ff:00.2: Adding to iommu group 370
> [   42.445290] pci 0000:ff:00.3: Adding to iommu group 371
> [   42.451225] pci 0000:ff:00.4: Adding to iommu group 372
> [   42.457162] pci 0000:ff:00.5: Adding to iommu group 373
> [   42.463097] pci 0000:ff:00.6: Adding to iommu group 374
> [   42.469030] pci 0000:ff:00.7: Adding to iommu group 375
> [   42.474973] pci 0000:ff:01.0: Adding to iommu group 376
> [   42.480909] pci 0000:ff:01.1: Adding to iommu group 377
> [   42.486842] pci 0000:ff:01.2: Adding to iommu group 378
> [   42.492778] pci 0000:ff:01.3: Adding to iommu group 379
> [   42.498713] pci 0000:ff:01.4: Adding to iommu group 380
> [   42.504648] pci 0000:ff:01.5: Adding to iommu group 381
> [   42.510575] pci 0000:ff:01.6: Adding to iommu group 382
> [   42.516510] pci 0000:ff:01.7: Adding to iommu group 383
> [   42.522453] pci 0000:ff:02.0: Adding to iommu group 384
> [   42.528389] pci 0000:ff:02.1: Adding to iommu group 385
> [   42.534326] pci 0000:ff:02.2: Adding to iommu group 386
> [   42.540259] pci 0000:ff:02.3: Adding to iommu group 387
> [   42.546194] pci 0000:ff:02.4: Adding to iommu group 388
> [   42.552129] pci 0000:ff:02.5: Adding to iommu group 389
> [   42.558053] pci 0000:ff:02.6: Adding to iommu group 390
> [   42.563986] pci 0000:ff:02.7: Adding to iommu group 391
> [   42.569930] pci 0000:ff:03.0: Adding to iommu group 392
> [   42.575870] pci 0000:ff:03.1: Adding to iommu group 393
> [   42.581808] pci 0000:ff:03.2: Adding to iommu group 394
> [   42.587743] pci 0000:ff:03.3: Adding to iommu group 395
> [   42.593679] pci 0000:ff:03.4: Adding to iommu group 396
> [   42.599613] pci 0000:ff:03.5: Adding to iommu group 397
> [   42.605548] pci 0000:ff:03.6: Adding to iommu group 398
> [   42.611473] pci 0000:ff:03.7: Adding to iommu group 399
> [   42.617407] pci 0000:ff:04.0: Adding to iommu group 400
> [   42.623343] pci 0000:ff:04.1: Adding to iommu group 401
> [   42.629281] pci 0000:ff:04.2: Adding to iommu group 402
> [   42.635214] pci 0000:ff:04.3: Adding to iommu group 403
> [   42.641151] pci 0000:ff:04.4: Adding to iommu group 404
> [   42.647084] pci 0000:ff:04.5: Adding to iommu group 405
> [   42.653020] pci 0000:ff:04.6: Adding to iommu group 406
> [   42.658954] pci 0000:ff:04.7: Adding to iommu group 407
> [   42.664887] pci 0000:ff:05.0: Adding to iommu group 408
> [   42.670821] pci 0000:ff:05.1: Adding to iommu group 409
> [   42.676745] pci 0000:ff:05.2: Adding to iommu group 410
> [   42.682682] pci 0000:ff:05.3: Adding to iommu group 411
> [   42.688618] pci 0000:ff:05.4: Adding to iommu group 412
> [   42.694554] pci 0000:ff:05.5: Adding to iommu group 413
> [   42.700488] pci 0000:ff:05.6: Adding to iommu group 414
> [   42.706421] pci 0000:ff:05.7: Adding to iommu group 415
> [   42.712373] pci 0000:ff:06.0: Adding to iommu group 416
> [   42.718308] pci 0000:ff:06.1: Adding to iommu group 417
> [   42.724242] pci 0000:ff:06.2: Adding to iommu group 418
> [   42.730175] pci 0000:ff:06.3: Adding to iommu group 419
> [   42.736111] pci 0000:ff:06.4: Adding to iommu group 420
> [   42.742046] pci 0000:ff:06.5: Adding to iommu group 421
> [   42.747981] pci 0000:ff:06.6: Adding to iommu group 422
> [   42.753915] pci 0000:ff:06.7: Adding to iommu group 423
> [   42.759853] pci 0000:ff:0a.0: Adding to iommu group 424
> [   42.765789] pci 0000:ff:0a.1: Adding to iommu group 425
> [   42.771725] pci 0000:ff:0a.2: Adding to iommu group 426
> [   42.777661] pci 0000:ff:0a.3: Adding to iommu group 427
> [   42.783598] pci 0000:ff:0a.4: Adding to iommu group 428
> [   42.789536] pci 0000:ff:0a.5: Adding to iommu group 429
> [   42.795475] pci 0000:ff:0a.6: Adding to iommu group 430
> [   42.801409] pci 0000:ff:0a.7: Adding to iommu group 431
> [   42.807352] pci 0000:ff:0b.0: Adding to iommu group 432
> [   42.813287] pci 0000:ff:0b.1: Adding to iommu group 433
> [   42.819223] pci 0000:ff:0b.2: Adding to iommu group 434
> [   42.825159] pci 0000:ff:0b.3: Adding to iommu group 435
> [   42.831093] pci 0000:ff:0b.4: Adding to iommu group 436
> [   42.837067] pci 0000:ff:0b.5: Adding to iommu group 437
> [   42.843002] pci 0000:ff:0b.6: Adding to iommu group 438
> [   42.848928] pci 0000:ff:0b.7: Adding to iommu group 439
> [   42.854868] pci 0000:ff:0c.0: Adding to iommu group 440
> [   42.860803] pci 0000:ff:0c.1: Adding to iommu group 441
> [   42.866739] pci 0000:ff:0c.2: Adding to iommu group 442
> [   42.872674] pci 0000:ff:0c.3: Adding to iommu group 443
> [   42.878611] pci 0000:ff:0c.4: Adding to iommu group 444
> [   42.884549] pci 0000:ff:0c.5: Adding to iommu group 445
> [   42.890487] pci 0000:ff:0c.6: Adding to iommu group 446
> [   42.896423] pci 0000:ff:0c.7: Adding to iommu group 447
> [   42.902363] pci 0000:ff:0d.0: Adding to iommu group 448
> [   42.908299] pci 0000:ff:0d.1: Adding to iommu group 449
> [   42.914235] pci 0000:ff:0d.2: Adding to iommu group 450
> [   42.920174] pci 0000:ff:0d.3: Adding to iommu group 451
> [   42.926109] pci 0000:ff:0d.4: Adding to iommu group 452
> [   42.932047] pci 0000:ff:0d.5: Adding to iommu group 453
> [   42.937983] pci 0000:ff:0d.6: Adding to iommu group 454
> [   42.943919] pci 0000:ff:0d.7: Adding to iommu group 455
> [   42.949862] pci 0000:ff:0e.0: Adding to iommu group 456
> [   42.955796] pci 0000:ff:0e.1: Adding to iommu group 457
> [   42.961721] pci 0000:ff:0e.2: Adding to iommu group 458
> [   42.967658] pci 0000:ff:0e.3: Adding to iommu group 459
> [   42.973593] pci 0000:ff:0e.4: Adding to iommu group 460
> [   42.979532] pci 0000:ff:0e.5: Adding to iommu group 461
> [   42.985470] pci 0000:ff:0e.6: Adding to iommu group 462
> [   42.991405] pci 0000:ff:0e.7: Adding to iommu group 463
> [   42.997351] pci 0000:ff:0f.0: Adding to iommu group 464
> [   43.003290] pci 0000:ff:0f.1: Adding to iommu group 465
> [   43.009228] pci 0000:ff:0f.2: Adding to iommu group 466
> [   43.015163] pci 0000:ff:0f.3: Adding to iommu group 467
> [   43.021100] pci 0000:ff:0f.4: Adding to iommu group 468
> [   43.027036] pci 0000:ff:0f.5: Adding to iommu group 469
> [   43.032976] pci 0000:ff:0f.6: Adding to iommu group 470
> [   43.038912] pci 0000:ff:0f.7: Adding to iommu group 471
> [   43.044854] pci 0000:ff:10.0: Adding to iommu group 472
> [   43.050792] pci 0000:ff:10.1: Adding to iommu group 473
> [   43.056731] pci 0000:ff:10.2: Adding to iommu group 474
> [   43.062668] pci 0000:ff:10.3: Adding to iommu group 475
> [   43.068608] pci 0000:ff:10.4: Adding to iommu group 476
> [   43.074542] pci 0000:ff:10.5: Adding to iommu group 477
> [   43.080471] pci 0000:ff:10.6: Adding to iommu group 478
> [   43.086408] pci 0000:ff:10.7: Adding to iommu group 479
> [   43.092362] pci 0000:ff:1d.0: Adding to iommu group 480
> [   43.098302] pci 0000:ff:1d.1: Adding to iommu group 481
> [   43.104636] pci 0000:ff:1e.0: Adding to iommu group 482
> [   43.110621] pci 0000:ff:1e.1: Adding to iommu group 482
> [   43.116605] pci 0000:ff:1e.2: Adding to iommu group 482
> [   43.122590] pci 0000:ff:1e.3: Adding to iommu group 482
> [   43.128574] pci 0000:ff:1e.4: Adding to iommu group 482
> [   43.134556] pci 0000:ff:1e.5: Adding to iommu group 482
> [   43.140538] pci 0000:ff:1e.6: Adding to iommu group 482
> [   43.146522] pci 0000:ff:1e.7: Adding to iommu group 482
> [   43.153222] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [   43.160471] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [   43.167715] software IO TLB: mapped [mem 0x000000006123e000-0x000000006523e000] (64MB)
> [   43.178633] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> [   43.187540] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   43.193906] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   43.199984] RAPL PMU: hw unit of domain psys 2^-0 Joules
> 
> 
> Thanks
> 
> -Li
> 
>> Thanks,
>> Robin.
>>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>> ---
>>>    drivers/iommu/iommu.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
>>> 83c8e61..a16f944 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1193,7 +1193,7 @@ static struct group_device
>>> *iommu_group_alloc_device(struct iommu_group *group,
>>>
>>>    	trace_add_device_to_group(group->id, dev);
>>>
>>> -	dev_info(dev, "Adding to iommu group %d\n", group->id);
>>> +	dev_dbg(dev, "Adding to iommu group %d\n", group->id);
>>>
>>>    	return device;
>>>
