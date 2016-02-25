From: Laura Abbott <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Warning from AMD IOMMU performance counters
Date: Thu, 25 Feb 2016 09:47:14 -0800
Message-ID: <56CF3E22.7080402@redhat.com>
References: <56C798B8.6080009@redhat.com> <56CA69C7.3050508@iommu.org>
	<56CBB789.4020704@redhat.com> <56CC963A.1080607@redhat.com>
	<20160223175113.GA3711@pd.tnic> <20160225145716.GA18581@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160225145716.GA18581-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 02/25/2016 06:57 AM, Joerg Roedel wrote:
> On Tue, Feb 23, 2016 at 06:51:13PM +0100, Borislav Petkov wrote:
>> On Tue, Feb 23, 2016 at 09:26:18AM -0800, Laura Abbott wrote:
>>> It was an issue with build signing on the testers machine. Once that was
>>> fixed it was confirmed that the patches did fix the issue.
>>
>> Btw, Joerg did come up with a minimal fix today:
>>
>> https://lkml.kernel.org/r/20160223121215.GA31151-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
>>
>> in case you want to run it instead of that big patchset which is still
>> being reviewed...
>
> I just queued that small fix and tagged it for stable. Suravees patches
> are too intrusive for that and better suited for v4.6.
>
>
> 	Joerg
>

Thanks, I did end up pulling in that small fix.
