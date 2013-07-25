From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/4] iommu: Add event tracing feature to iommu
Date: Thu, 25 Jul 2013 09:27:21 -0400
Message-ID: <1374758841.3356.174.camel@gandalf.local.home>
References: <cover.1374711464.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1374711464.git.shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, Varun.Sethi@freescale.com, aik@ozlabs.ru, joe@perches.com, fweisbec@gmail.com, mingo@redhat.com, tony@atomide.com, ohad@wizery.com, andreas.herrmann@calxeda.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Thu, 2013-07-25 at 07:15 -0600, Shuah Khan wrote:

> Shuah Khan (4):
>   iommu: Add event tracing feature to iommu - Add iommu trace events
>   iommu: Add event tracing feature to iommu - export trace events
>   iommu: Add event tracing feature to iommu - amd_iommu driver trace
>     events
>   iommu: Add event tracing feature to iommu - iommu driver trace events
> 
>  drivers/iommu/Makefile       |    1 +
>  drivers/iommu/amd_iommu.c    |   19 +++++
>  drivers/iommu/iommu-traces.c |   27 +++++++
>  drivers/iommu/iommu.c        |   17 ++++-
>  include/trace/events/iommu.h |  174 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 237 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/iommu-traces.c
>  create mode 100644 include/trace/events/iommu.h

I don't know what the maintainer thinks, but usually new tracepoints
like this are done as one patch. Not four.

-- Steve
