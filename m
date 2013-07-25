From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH 0/4] iommu: Add event tracing feature to iommu
Date: Thu, 25 Jul 2013 23:11:16 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6174A596@sisaex01sj>
References: <cover.1374711464.git.shuah.kh@samsung.com>
 <1374758841.3356.174.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "joe@perches.com" <joe@perches.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "tony@atomide.com" <tony@atomide.com>, "ohad@wizery.com" <ohad@wizery.com>, "andreas.herrmann@calxeda.com" <andreas.herrmann@calxeda.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 07/25/2013 07:27 AM, Steven Rostedt wrote:
> On Thu, 2013-07-25 at 07:15 -0600, Shuah Khan wrote:
>
>> Shuah Khan (4):
>>    iommu: Add event tracing feature to iommu - Add iommu trace events
>>    iommu: Add event tracing feature to iommu - export trace events
>>    iommu: Add event tracing feature to iommu - amd_iommu driver trace
>>      events
>>    iommu: Add event tracing feature to iommu - iommu driver trace events
>>
>>   drivers/iommu/Makefile       |    1 +
>>   drivers/iommu/amd_iommu.c    |   19 +++++
>>   drivers/iommu/iommu-traces.c |   27 +++++++
>>   drivers/iommu/iommu.c        |   17 ++++-
>>   include/trace/events/iommu.h |  174 ++++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 237 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/iommu/iommu-traces.c
>>   create mode 100644 include/trace/events/iommu.h
>
> I don't know what the maintainer thinks, but usually new tracepoints
> like this are done as one patch. Not four.
>
> -- Steve
>

If one single patch is preferred, I can easily generate one. Does the 
code look good otherwise?

-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
