From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Regression since 4.1
Date: Mon, 28 Dec 2015 17:49:18 +0100
Message-ID: <20151228164918.GN18805@8bytes.org>
References: <5418503.92eb9JWhCR@t400> <1449688068.15753.461.camel@redhat.com>
	<6847091.8HQyRDvvTU@pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6847091.8HQyRDvvTU@pc>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tobias Geiger <tobias.geiger-9woOUGhjKTphl2p70BpVqQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tobias,

On Thu, Dec 10, 2015 at 12:07:57AM +0100, Tobias Geiger wrote:
> It all comes down to kernel > 4.1 && iommu=on = not working here
> 
> Hardware is:
> Intel DX58SO, Intel CPU i7 920... all pretty solid running for years now, 
> always with iommo=on.
> 
> I'd love to debug this further, just dont know how...

Sounds like only bisecting the issue will help here. You can find an
introduction on bisecting here:

	https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git

Would be great if you can find the time to bisect the issue.



	Joerg
