From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v9 0/8] perf/amd/iommu: Enable multi-IOMMU support
Date: Wed, 15 Feb 2017 11:44:24 +0100
Message-ID: <20170215104424.GA8207@krava>
References: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20170215101323.ecggpvbkbcqaq5xs@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170215101323.ecggpvbkbcqaq5xs@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, peterz@infradead.org, joro@8bytes.org, mingo@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 15, 2017 at 11:13:23AM +0100, Borislav Petkov wrote:
> On Tue, Feb 07, 2017 at 02:40:28AM -0600, Suravee Suthikulpanit wrote:
> > From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > 
> > This patch series modifies the existing IOMMU and Perf drivers to support
> > systems with multiple IOMMUs by allocating an amd_iommu PMU per IOMMU instance.
> > This allows users to specify performance events and filters separately for each
> > IOMMU.
> > 
> > This has been tested on the new family17h-based server w/ multiple IOMMUs.
> 
> Ok, so far so good.
> 
> There's just one thing:
> 
> $ perf stat -e amd_iommu_X/Y
> 
> says <not supported> and only doing the system wide tracing with -a does
> it count events.

does it say unsupported when you omit -a? it should display error
and options like:

[jolsa@krava perf]$ ./perf stat -e 'cpu/cpu-cycles/'

 Usage: perf stat [<options>] [<command>]

    -a, --all-cpus        system-wide collection from all CPUs
    -A, --no-aggr         disable CPU count aggregation
    -B, --big-num         print large numbers with thousands' separators
    -C, --cpu <cpu>       list of cpus to monitor in system-wide
...


> 
> So, lemme ask perf tool people, can we guys make the -a thing default
> when detect that we're running only uncore events which all should need
> -a anyway?

it's possible, can't think of anything being hurt by this now..

jirka
