From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [git pull] IOMMU Updates for Linux v4.2
Date: Wed, 24 Jun 2015 09:09:02 +0200
Message-ID: <20150624070902.GA18569@8bytes.org>
References: <20150623092412.GA25264@8bytes.org>
	<CA+55aFxZL24-8H1e=zYaVYrvnO-T01kqUN4R6DFF37TOHdi=Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxZL24-8H1e=zYaVYrvnO-T01kqUN4R6DFF37TOHdi=Gw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 23, 2015 at 06:47:15PM -0700, Linus Torvalds wrote:
> Hmm. My resolution doesn't look the same at all, but that could easily
> be due to trivial differences. I tried to make as much sense of the
> merge as possible, so I think my merge is fine, but it's also entirely
> possible I screwed something up.

Your resolution looks good (there is only a missing newline after the
declarations in intel_free_irq_resources). The only other difference to
my resolution is that you kept the new set_irq_posting_cap() function at
the original location, I moved it to a different place in the file. But
these differences don't matter for functionality, so everything is fine :)


Thanks,

	Joerg
