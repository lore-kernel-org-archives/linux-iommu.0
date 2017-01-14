From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 4/7] perf/amd/iommu: Declare pr_fmt and remove
	unnecessary pr_debug
Date: Sat, 14 Jan 2017 17:13:33 +0700
Message-ID: <fdbd3d91-9b01-20a2-50a7-1ae6a0d71a47@amd.com>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484019227-11473-5-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170112101942.5z6e6s344awbi4uk@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170112101942.5z6e6s344awbi4uk-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 1/12/17 17:19, Borislav Petkov wrote:
> Also, looking at that driver more, this needs to die, like now:
>
> #define format_group    attr_groups[0]
> #define cpumask_group   attr_groups[1]
> #define events_group    attr_groups[2]
> #define null_group      attr_groups[3]
>
> Like, kill it dead. Define a separate array, look what the other drivers
> do, whatever, but this is too ugly to live.
>
> Thanks.
>
> --

Okay... you got it :)

S
