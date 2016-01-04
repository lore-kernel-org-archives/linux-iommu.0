From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/7] Intel IOMMU scalability improvements
Date: Mon, 4 Jan 2016 18:35:10 +0100
Message-ID: <20160104173510.GT18805@8bytes.org>
References: <20151228161421.GA27829@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151228161421.GA27829-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Adam,

On Mon, Dec 28, 2015 at 06:14:21PM +0200, Adam Morrison wrote:
> This patchset improves the scalability of the Intel IOMMU code by
> resolving two spinlock bottlenecks, yielding up to ~10x performance
> improvement and approaching iommu=off performance.
> 
> For example, here's the throughput obtained by 16 memcached instances
> running on a 16-core Sandy Bridge system, accessed using memslap on
> another machine that has iommu=off, using the default memslap config
> (64-byte keys, 1024-byte values, and 10%/90% SET/GET ops):
> 
>     stock iommu=off:
>        1,088,996 memcached transactions/sec (=100%, median of 10 runs).
>     stock iommu=on:
>        123,760 memcached transactions/sec (=11%).
>        [perf: 43.56%    0.86%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave]
>     patched iommu=on:
>        1,067,586 memcached transactions/sec (=98%).
>        [perf: 0.75%     0.75%  memcached       [kernel.kallsyms]      [k] _raw_spin_lock_irqsave]
>

Thanks for the patches, the results look pretty impressive. I'll have a
closer look at your changes this week.



	Joerg
