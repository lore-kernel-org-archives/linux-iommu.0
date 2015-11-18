From: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Subject: Re: [PATCH 0/4 v2] Implement access checks in iommu page fault paths
Date: Wed, 18 Nov 2015 08:13:56 -0800
Message-ID: <564CA3C4.60609@virtuousgeek.org>
References: <1447773099-2444-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1447773099-2444-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/17/2015 07:11 AM, Joerg Roedel wrote:
> Hi,
> 
> here is the second version of the patch-set to implement
> proper access checks into the io-page-fault handlers of the
> AMD IOMMU and Intel VT-d drivers.
> 
> Two additional patches clean up the AMD part a bit further.
> Since I can't test this this code myself due to lack of
> hardware or software that utilizes it, I'd appreciate some
> external testing.
> 
> It took me a while to get these out, mostly because I tried
> to setup my own HSA test environment to at least test the
> AMD changes myself. That failed, so I am sending this out
> with another request for testing.
> 
> Oded, Jesse, would you two please test these patches and
> report back? Thanks a lot!

I might be able to find time later this week or next; I have to update
my tree to David's latest bits and rebase my i915 code on top along with
these patches.  Then I can run some of my tests and expand them to try
r/w tests w/o mapping the buffer with the right access mode.

Jesse
