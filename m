From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [git pull] IOMMU Updates for Linux v4.2
Date: Tue, 23 Jun 2015 18:47:15 -0700
Message-ID: <CA+55aFxZL24-8H1e=zYaVYrvnO-T01kqUN4R6DFF37TOHdi=Gw@mail.gmail.com>
References: <20150623092412.GA25264@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150623092412.GA25264-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 23, 2015 at 2:24 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>
> I attached my resolution of the conflicts to this pull-request and
> compiled and run-time tested my resolution on an Intel VT-d and an
> AMD IOMMU machine.

Hmm. My resolution doesn't look the same at all, but that could easily
be due to trivial differences. I tried to make as much sense of the
merge as possible, so I think my merge is fine, but it's also entirely
possible I screwed something up.

In general, when there are complex merges, I still tend to prefer to
do them myself, but if you *also* have a pre-merged branch, I can then
compare my merge against yours. I tend find that the maintainer has
had a broken merge more often than mine (just because I'm so used to
merging), but the reverse also does happen, and it's often very useful
to be able to compare the two merges for sanity.

And for conflicts that are trivial, don't even bother. In this case,
like you to double-check my end result. It looks sane, and it
compiles, but hey..

              Linus
